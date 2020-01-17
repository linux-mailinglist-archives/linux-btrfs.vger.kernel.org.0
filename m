Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAF140C11
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAQOHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:07:44 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:39493 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:07:44 -0500
Received: by mail-qv1-f43.google.com with SMTP id y8so10737402qvk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9PrLcSCYVHoZuTCOiqxvr1ql+CNSqhlYHuKl0HJsTo=;
        b=bbmlzqDhfIlwPBD2hdiPkW+u9OMpvpI9H3nPsNEIBg6Cpz056c9AOp+gYwWDkM6rM3
         6FIBuZcVt3zzMuckGtBUs7K3z1FC7bevS+AhxAlOJoyFCnlfAmm4xqrVIehcpj1uBp+p
         U9stFMhF6A/SZhtQNK67tDTHWFfuKAMIyOoJWYQuaFrJMYlIhA32YyZhaKw/hYrTP1V0
         PCYFEHAUasY9tRz5e9Jfh3bAmVR7C9WObv2XevThTdix2ejCn5q4d1JU7ycR9TpgGN1F
         GfSeQ0rpdXMUKgIsrN9IF46owRWT2Y4WIYlMTfKm0i1GliCFKfNMJFYeJCaPNg109EjC
         bnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9PrLcSCYVHoZuTCOiqxvr1ql+CNSqhlYHuKl0HJsTo=;
        b=B6tF01P8FTwXg/e5OtwvGWLC7YTuwJ7zHFUxenCeW29gCInrKILOeqwdQ08iXfjJaI
         zX4X3G0g+iXOl4iI4+LcAssXDy1Qx1DbZTt/kdxUjnCeyLFDISH7oc9xh1aNmeDaSwsV
         wroudOivY1cAEY7fPhVvXQ3c9hX+Y17bq+VsN+omIX1ujEGy4YAYppR36gj0Dl8sSue5
         h+Vev8Pa9r/+IReg+ZGxhTQmz6wp5O+uAXUnRm+n12F9c0FT75LJtqMqyENggxJ79Ksp
         x+y8gcyQ08FJBpqzaY4hwhymOEYvNTLAEp30UErYJWP3qgnhnyl7JXMbbFqcug7DPYZv
         Wxsw==
X-Gm-Message-State: APjAAAWUjQ4YH+yc6j1It4BEJFB33vFu/AXtEoeHPxbdQ0Fc8MXwxVy4
        ZInvVnVqus8sLWCN1QgjixvMs1SbZhR4uw==
X-Google-Smtp-Source: APXvYqyoSsJtf5NyuCoWroi1azlqbKMU/23Z5ysatuY2cPTVv2qOO/B/QiLMp8QtymfSJa+f8Vb8hQ==
X-Received: by 2002:a05:6214:1149:: with SMTP id b9mr7721078qvt.227.1579270062691;
        Fri, 17 Jan 2020 06:07:42 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 21sm11797757qky.41.2020.01.17.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:07:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3][v2] clean up how we mark block groups read only
Date:   Fri, 17 Jan 2020 09:07:36 -0500
Message-Id: <20200117140739.42560-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebased onto misc-next.
- Fixed a bug where we weren't adjusting space_info->bytes_readonly in the force
  case.
- Dropped the RFC, these are pretty important fixes.

-------------- Original email ----------------------
Qu has been looking into ENOSPC during relocation and noticed some weirdness
with inc_block_group_ro.  The problem is this code hasn't changed to keep up
with the rest of the reservation system.  It still assumes that the amount of
space used will always be less than the total space for the space info, which
hasn't been true for years since I introduced overcommitting.  This logic is
correct for DATA, but not for METADATA or SYSTEM.

The first few patches are just cleanups, and can probably be taken as is.  The
final patch is the real meat of the problem to address Qu's issues.  This is an
RFC because I'm elbow deep in another problem and haven't tested this beyond
compile testing, but I think it'll work.  Once I've gotten a chance to test it
and Qu has tested it I'll update the list if it's good to go as is, or send a V2
with any changes.  Thanks,

Josef

