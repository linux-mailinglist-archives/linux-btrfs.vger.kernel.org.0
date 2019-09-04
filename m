Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E78CA824B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfIDMWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 08:22:23 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:42622 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDMWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 08:22:22 -0400
Received: by mail-io1-f45.google.com with SMTP id n197so41786406iod.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dy3lepqYLj1dMoa1drMYhBVSCCT/VuxkCAOgj3T7YWE=;
        b=oqw8BHEkOShjJfU28cZ0jnx2wRGIcsI0o8hqqy07oI9qm6aPWNjGCOCSFTouiTpw+X
         8nYiJBk061aAH5lsJKPyaU3A4JDLglgn3ctMxA2Mt/ev+aXWC7fxNgRyYiNkt4plYce2
         CiK4lcoA1jm0WiqZqV6pPAYOZI/O2j+REvNfcwXpZJ6F15Uz7oVu3n49TZEqILs/Gli5
         6j3JH4KUCR4fydO4lp3xvUOtR6dUcQl88QjzFYp5Q0yLBayIP6tP2CknBolQjCLPFIKE
         C0tDCZBQ6FakMiXpvd7biVFOkryfnlNuEu+FerLcyfthqN6efSIeVF/zxp2JfMmvUdGW
         n/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dy3lepqYLj1dMoa1drMYhBVSCCT/VuxkCAOgj3T7YWE=;
        b=Ok4MEf+sYjReXsGbWBleJn8HBWW8OmU31HqeLVZZy+HE2SToQ9xQDD2Trl69i3tGMb
         nLmUhg2eJlchjjxM+Bly03Se6cblbwXivln92H+PCGGB5QcnVZo6VJbqngLz/b58GXVS
         K0IVmkW4AvEUe1vUPMJFESRUpJtYOx7HdwFqdq/hHKB9obC/D8uYXfSfdRpYBBa9ThPc
         wuN0v73LsMumjDL8CwNxLnc+ZzlU9SI1Ad7ZzXW9jwpxWBOjukG0GGDX7yQh7mV1zSa1
         le9KhGbco+tx/rPbUoDR3vA4Ae6k2LI2/y2pUmwY2WmH1zyc36m+xMitmZ2ZafjqYM/N
         RBcQ==
X-Gm-Message-State: APjAAAURdY2yY7RAmsBWqBRPQrCVwyWCAmyOTC8pE7gU10V7iyYwUw69
        YUqU5//C2X3RNhQzkDYHfyVYx6/bsME=
X-Google-Smtp-Source: APXvYqxYuy6bFL0LP1MMFlJm8BPZQlK2DYYzuuxAlgw2tAEGS59z6jbHI+/aM2tfbKtSAPJZ2+zXMA==
X-Received: by 2002:a6b:8e57:: with SMTP id q84mr11531436iod.41.1567599741746;
        Wed, 04 Sep 2019 05:22:21 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id z14sm15135325iol.86.2019.09.04.05.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 05:22:21 -0700 (PDT)
Subject: Re: crypted btrfs in a file
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM6PR10MB3399F318A3BAA232A0BCAA48A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <effe8460-808b-e94f-33f5-b7a5ea4ec8f8@gmail.com>
Date:   Wed, 4 Sep 2019 08:22:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB3399F318A3BAA232A0BCAA48A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-04 02:23, Jorge Fernandez Monteagudo wrote:
> Hi all!
> 
> Is it possible to get a crypted btrfs in a file? Currently I'm doing this to get a crypted ISO filesystem in a file:
> 
> # genisoimage -R -J -iso-level 4 -o iso.img <dir_to_put_in_the_image>
> # fallocate iso-crypted.img -l $(stat --printf="%s" iso.img)
> # cryptsetup -d <key_to_crypt_iso> create test iso-crypted.img
> # dd if=iso.img of=/dev/mapper/test bs=512
> # sync
> # cryptsetup remove test >
> Is it possible to do something similar in btrfs? Is there something similar to 'genisoimage' in btrfs ? Or, at least, given a directory, is it possible to know the outcome size of the filesystem to create an empty file with fallocate and create a btrfs in a loop device like:
> 
> # fallocate btrfs-crypted.img -l <btrfs_size_for_dir_to_put_in_the_image>
> # losetup /dev/loop0 btrfs-crypted.img
> # mkfs.btrfs /dev/loop0
> 
> then we can mount the loop0, copy the files, unmount and then crypt the btrfs-crypted.img like the ISO one.
What you want here is mkfs.btrfs with the `-r` and `--shrink` options.

So, for your specific example, replace the genisoimage command from your 
first example with this and update the file names appropriately:

# mkfs.btrfs -r <dir_to_put_in_the_image> --shrink btrfs.img

Note that you don't need and shouldn't use a loop mount for the target 
file for the `mkfs` command.  It will generate the file at the 
appropriate size automatically (and as a general rule, `mkfs` for any 
filesystem works just fine without a loop mount, you just need to have a 
file of the right size for most of them).
