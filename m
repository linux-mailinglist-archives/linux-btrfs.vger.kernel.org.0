Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD43E3B4C38
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 05:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZDlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 23:41:05 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38778 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFZDlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 23:41:04 -0400
Received: by mail-pl1-f179.google.com with SMTP id 69so5716858plc.5;
        Fri, 25 Jun 2021 20:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJnKu8VyGHUHakkNx3B7bfcptdv9iXQ+SKMU8fbrCYo=;
        b=BPZnXw21NSzKPZ/JZZ8lPSqZCIwO1/2Iy8zKPrp7xsAwT7onRihlZP68WG4xF9+3iz
         HoYKoO3kX8/Tjo2NmkUZP18FpCqQSPZc78O/NCnqqXRhECQknUA2CsiT/T4dTqtgAJjx
         g9a12qAH/fbZztRF+H13tgDoJW+MzMEmDOp8/VpUjh7rXRdcbsPjztk7qMLOoKr0ZjSQ
         TmaTBwVHd/ctrnYZ/ZxY6n6uaHFTuP0PVHLWMGXInHe8E0oytOY8CA5fmVG8dV0dUC8Q
         CIfx9emqgPjVdLprz/w9dW0ohv95Uwew68p+6usoIoSFOOaBQQu3gWMx7TcgPwUbFXgm
         pRPg==
X-Gm-Message-State: AOAM533vkteFJLRt8BiRnmTnSFzIRcaeS6xVaYVO+HzC0F5lPC+ZlM2x
        LEjvtqMg5DLVudcB31vz/3gVRJSAdVg=
X-Google-Smtp-Source: ABdhPJxM5JqS4cODA4DV4/M1Oke6f+YPVYkHMq4B00IWIYOG3lAFx1uiQcGOu/BSAH8GD/uD2xkHUg==
X-Received: by 2002:a17:902:446:b029:120:1fd:adbf with SMTP id 64-20020a1709020446b029012001fdadbfmr12252905ple.52.1624678722222;
        Fri, 25 Jun 2021 20:38:42 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 135sm7152412pgf.20.2021.06.25.20.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 20:38:41 -0700 (PDT)
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search
 Baloo
To:     NeilBrown <neilb@suse.de>, Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <41661070.mPYKQbcTYQ@ananda>
 <162466884942.28671.6997551060359774034@noble.neil.brown.name>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ec60fd7f-7020-5168-81f1-809da73763f3@acm.org>
Date:   Fri, 25 Jun 2021 20:38:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162466884942.28671.6997551060359774034@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/25/21 5:54 PM, NeilBrown wrote:
> On Sat, 26 Jun 2021, Martin Steigerwald wrote:
>>                                  And that Baloo needs an "invariant" for 
>> a file. See comment #11 of that bug report:
> 
> That is really hard to provide in general.  Possibly the best approach
> is to use the statfs() systemcall to get the "f_fsid" field.  This is
> 64bits.  It is not supported uniformly well by all filesystems, but I
> think it is at least not worse than using the device number.  For a lot
> of older filesystems it is just an encoding of the device number.
> 
> For btrfs, xfs, ext4 it is much much better.

How about combining the UUID of the partition with the file path? An
example from one of the VMs on my workstation:

$ df .
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/vda1       25670972 12730276  11613648  53% /
$ lsblk -O | grep vda1
└─vda1 vda1  /dev/vda1 252:1     11.1G  24.5G ext4    12.1G    50% 1.0
 /                84cebea8-7e6f-4c2a-8a1b-8bc0c9744751 ae2151de
                    dos    0x83     Linux                  ae2151de-01
                        0x80      128  0  0       0
                 25G         root  disk  brw-rw----         0    512
  0     512     512    1 mq-deadline     256 part        0      512B
   2G         0    0B        0 vda                      block:virtio:pci
                   none    0

In other words, UUID 84cebea8-7e6f-4c2a-8a1b-8bc0c9744751 has been
associated with the block device under the filesystem that owns the
directory from which the 'df' command has been run.

Bart.
