Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE57318203A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCKSAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:00:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39753 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbgCKSAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:00:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id e16so2977975qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9oqOH5VpLEDWFR76mqOW/rldjQsWUwreUar8WVyZaU=;
        b=cmD486bQpXLYRNyzZzK6j8sRaApXKcQEGYgsI6HdNwLKc+EXdTy405OZhveSvDm+Bb
         2LkITA/y0XqK5v+DutaLFt2MNmm1WS2x212WeHjQsEGz4kP0oyjOAT87rlYIFa76izTb
         EsZQtfNHWcih+VzgnqJdJ0eMzv1YuNIg4+bXZRTkmnRtVKJ+vVBSU9of2fRw4c/64Waw
         aT/xBJ+qLD+hTqOmmJ/olm97cZLuqEDWpZg9U3dQ6e5dngFFHeiszVLMXNvRX/uw7pzZ
         raYB6ttXGCUPq6OfzsU7TWN1L1lX3gv5T8MQLVh1tUvsFBM0wpqsjdlaTy5YmNAhhYZL
         vOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9oqOH5VpLEDWFR76mqOW/rldjQsWUwreUar8WVyZaU=;
        b=uchsq2Ybo63o//GywoPtZORZVx+OEup59dBRXvYv79kZfd/ok8FEhRF6o7TO/QqBc2
         TZCLKSptraWwR9QmLRz9E5phY64QRUOoMyuORqCInS84Mh0DLszuZcicVUFPSJ/Ao2TR
         QDtN4Lhi7+JGfkexyDLYpTz+MccshHm2r2urRz02TCo0wPil9zvO8kPfO93ZfALhg1l6
         1rjT7rtVV6N4sOrpSAaBo1syC/wZmxI8OtsnDsdEykPYMD5GhhWwESPmt5WOSSrxm+aa
         5L2gBynjgYmT30jhJVcQ8uIyEN9wEICk1md64vVm0QK+H1q+tekUwgEN6LjpgsiAW4IG
         0g/A==
X-Gm-Message-State: ANhLgQ1pmsaImFQJmrWI7nllJxxx1kwbYaDcYcAj3yRjCIYPDU9FGft/
        ps6bbRgFTRZtkZOZ6dVHDmE2sFo8KBU=
X-Google-Smtp-Source: ADFU+vuLbgsrHBDBacJxTmMm+EZ2CZx1oAoOuaaApQVVs14afMZ6kWvNhARpIaV5JWaK7EG3WKdvQQ==
X-Received: by 2002:a37:b8c2:: with SMTP id i185mr3861115qkf.156.1583949622575;
        Wed, 11 Mar 2020 11:00:22 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l13sm11400292qke.116.2020.03.11.11.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:00:21 -0700 (PDT)
Subject: Re: [PATCH 10/15] btrfs: convert btrfs_dio_private->pending_bios to
 refcount_t
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <ca4884807ed430e3f546e50cc06678517f439df7.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <76af30b3-4d3b-4016-308d-3bf4c3f0d763@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:00:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ca4884807ed430e3f546e50cc06678517f439df7.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is really a reference count now, so convert it to refcount_t and
> rename it to refs.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
