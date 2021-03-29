Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35B34CF84
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC2L5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 07:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhC2L5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 07:57:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140DCC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 04:57:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d191so6475567wmd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FnBvxM70j/kelEKjS1bZYeYhzD1qjSDw7n5oMj/HbBI=;
        b=oJxqFeLKiRc0QhEb9RT3lfomItU9nRRsfbXj6yFXGZ29Wi5BXGACogfCPcVkNil2X1
         SqufzJyqt9SJwpIvvmg6+FJBfk+Cj8dYs4oI3E6ct4gNk1Shwyds556xi8VlZuYaVOF+
         EfItXr+acYRdx52rfKljvmxEGae7V1kIBVvl0ZnqjMfYQw1MDFSfx8dkcsgpCqGpvUQX
         srs+auF+eiEcv5Ron/WJKZF0Aru1u2KE6CX0qk5TfUuNzKSy+IXcnFdLPX40BELSg6vD
         /e3c45zcq3aqSKDjAouJXwpJP81TQU2Jh3DQmjMV28NaSW7FTKwViMC04XL6i7EHxVjy
         +r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FnBvxM70j/kelEKjS1bZYeYhzD1qjSDw7n5oMj/HbBI=;
        b=YvJBFBfMgm8Ys49lx/8ngJOlYeg6n/rLCRbqQinsROvaMsl357cu5mJOxAOgfA7AJg
         qY1dm4USAE2Wg3Bc9Hjr0MGhYZbDldqWWBk5Eec1skzf7TZpGF1uWJbGBnYAVv0uh1Rr
         l3WzzfeIwpYOV1uZ3vm9OpLAnP49LExbFsR9+ixx/v8dxDs7uqPoYgXQoFWMS7YIgpx5
         yezhNACcfDmGuXwusxgn8ml/24p6SdEr/egJK7mO1mREzSeqgMgVRHmKgyyxdw+bFw0j
         pzDivdaRr80JYPAY+ZFEaT3zY5126zMKR7j6poq3Zdi0tbQHkxFo+fCucdLXtcJI47mR
         ojyA==
X-Gm-Message-State: AOAM532Uf9Lorlj0kMjBS6M8XLxPI7cNKBy0mHmT4zfag6adSqK5PpXA
        sd3BFk6l6zjqumGXF/veV14=
X-Google-Smtp-Source: ABdhPJxj1B4tAUjWSAjrJvmvXaa7Xx1sTUF/YgsotoAzarLs1yf8kzT7k0kMfIY1iITgln2Tj5r9mg==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr24170956wmo.8.1617019023925;
        Mon, 29 Mar 2021 04:57:03 -0700 (PDT)
Received: from [192.168.1.71] ([102.64.198.202])
        by smtp.gmail.com with ESMTPSA id f2sm25911698wmp.20.2021.03.29.04.57.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 29 Mar 2021 04:57:03 -0700 (PDT)
Message-ID: <6061c08f.1c69fb81.5d5fd.f857@mx.google.com>
From:   Evelyn Robinson <boubacar9081@gmail.com>
X-Google-Original-From: Evelyn Robinson
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Sevgili
To:     Recipients <Evelyn@vger.kernel.org>
Date:   Sun, 28 Mar 2021 23:56:22 -0700
Reply-To: robinsonevelyn997@gmail.com
X-Antivirus: Avast (VPS 210329-0, 03/28/2021), Outbound message
X-Antivirus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm Evelyn, I need to discuss something with you, I hope we can start a rel=
ationship from here. I hope to come here soon. Thanks.

-- 
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

