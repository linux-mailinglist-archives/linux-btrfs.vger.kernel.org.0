Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAC24D76A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUOir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOin (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:38:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3BC061573
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:38:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so706246qvh.12
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RQzpqsT5Ya1eHoUv7vIIPMl1zW+oE/2pDRHNVBHgqQ=;
        b=JEbrld5qjvkltMTKZyNL96OwPH1dBcX5JPraolYq2DkGw6at2idy9eBO1wuSeCjf0K
         vfIW8VT9wLz8fIhEujbIlkwVUNuDOQLGJC31P9BqD/aH/DiaPpxD+TIDF5Z18RAiXXj9
         shjx5rqkh3SGpDKonMNgV8SDvYVPUT3Sa4i5Vk9hntRmF6VM8ZX8U1MaRLENI1tDqF0L
         A+r3pobY84YWcnW4nDRfZMJnAh+M+GMaQqOc8YzSogSHrgv7ZSmQvYpvgP0TtDDv3tu/
         sESVt/9H40P3z3w8lwYbsWwDArkwJ1OxhaTrbHSsYta4t7Tp93MiYau1NgZftHrYJbXn
         Ag0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RQzpqsT5Ya1eHoUv7vIIPMl1zW+oE/2pDRHNVBHgqQ=;
        b=jZPlk6oVGPCFle79c39fU2gOCbVQw5xNUQCW9Hnjz9b7v935P21GLDiRnJUldepglb
         mK7sZGDym70B92IxOfiYuLp2kZGbnqg82NDmyn51Flzv5ppjs3tixkzfFwHKZvRFtxSO
         3ErdJLXH9cNIWScEVYAWfP2W52GeiSa3aMOoaK5EssuXKJs8mppP+NbtB5COFgomCeCV
         uux6f4CEMA/iLNDT+mCSsrIkjaBrc7PfWxkUAlN9PGsi1yUkwzxReiEn5o/yN+Ck0XdE
         OLQN5WpkSHPKwORn3ucUFQphATE0gIaKFnrck1TacbwTGR3jAGueCzoPCzAksBTRLYL2
         rkwQ==
X-Gm-Message-State: AOAM5312FNZEi8MMa4dBReF/Q9wLX6M/VoygHssmExz6BOnvxav1rE0D
        xZV5KhE7MOZitzu+Z0Cq2do9ii4yJUqQBQ==
X-Google-Smtp-Source: ABdhPJy492hSt3yFkvG2+dj6Avz8t8PZ17svi7lEEFIz4chce5wOnLxGMwUzh22Gcf+DqZSnzpexQA==
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr2574075qvb.78.1598020721052;
        Fri, 21 Aug 2020 07:38:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:a347:d293:267e:e50:f799:d6f0])
        by smtp.gmail.com with ESMTPSA id b131sm1855841qkc.121.2020.08.21.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:38:40 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] btrfs: fix replace of seed device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
 <eb6040708e4f351ae668726862e3f112f64d8ab9.1598012410.git.anand.jain@oracle.com>
Cc:     boris@bur.io
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56431875-619d-fb49-efb2-9fcd265a8a69@toxicpanda.com>
Date:   Fri, 21 Aug 2020 10:38:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eb6040708e4f351ae668726862e3f112f64d8ab9.1598012410.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 9:15 AM, Anand Jain wrote:
> If you replace a seed device in a sprouted fs, it appears to have
> successfully replaced the seed device, but if you look closely, it didn't.
> 
> Here is an example.
> 
> mkfs.btrfs -fq /dev/sda
> btrfstune -S1 /dev/sda
> mount /dev/sda /btrfs
> btrfs dev add /dev/sdb /btrfs
> umount /btrfs; btrfs dev scan --forget
> mount -o device=/dev/sda /dev/sdb /btrfs
> btrfs rep start -f /dev/sda /dev/sdc /btrfs; echo $?
> 0
> 
>    BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to /dev/sdc started
>    BTRFS info (device sdb): dev_replace from /dev/sda (devid 1) to /dev/sdc finished
> 
> btrfs fi show
> Label: none  uuid: ab2c88b7-be81-4a7e-9849-c3666e7f9f4f
> 	Total devices 2 FS bytes used 256.00KiB
> 	devid    1 size 3.00GiB used 520.00MiB path /dev/sdc
> 	devid    2 size 3.00GiB used 896.00MiB path /dev/sdb
> 
> Label: none  uuid: 10bd3202-0415-43af-96a8-d5409f310a7e
> 	Total devices 1 FS bytes used 128.00KiB
> 	devid    1 size 3.00GiB used 536.00MiB path /dev/sda
> 
> So as per the replace start command and kernel log replace was successful.
> 
> Now let's try to clean mount.
> 
> umount /btrfs;  btrfs dev scan --forget
> 
> mount -o device=/dev/sdc /dev/sdb /btrfs
> mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/sdb, missing codepage or helper program, or other error.
> 
> [  636.157517] BTRFS error (device sdc): failed to read chunk tree: -2
> [  636.180177] BTRFS error (device sdc): open_ctree failed
> 
> That's because per dev items it is still looking for the original seed
> device.
> 
> btrfs in dump-tree -d /dev/sdb
> 
> 	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
> 		devid 1 total_bytes 3221225472 bytes_used 545259520
> 		io_align 4096 io_width 4096 sector_size 4096 type 0
> 		generation 6 start_offset 0 dev_group 0
> 		seek_speed 0 bandwidth 0
> 		uuid 59368f50-9af2-4b17-91da-8a783cc418d4  <--- seed uuid
> 		fsid 10bd3202-0415-43af-96a8-d5409f310a7e  <--- seed fsid
> 	item 1 key (DEV_ITEMS DEV_ITEM 2) itemoff 16087 itemsize 98
> 		devid 2 total_bytes 3221225472 bytes_used 939524096
> 		io_align 4096 io_width 4096 sector_size 4096 type 0
> 		generation 0 start_offset 0 dev_group 0
> 		seek_speed 0 bandwidth 0
> 		uuid 56a0a6bc-4630-4998-8daf-3c3030c4256a  <- sprout uuid
> 		fsid ab2c88b7-be81-4a7e-9849-c3666e7f9f4f <- sprout fsid
> 
> But the replaced target has the following uuid+fsid in its superblock
> which doesn't match with the expected uuid+fsid in its devitem.
> 
> btrfs in dump-super /dev/sdc | egrep '^generation|dev_item.uuid|dev_item.fsid|devid'
> generation	20
> dev_item.uuid	59368f50-9af2-4b17-91da-8a783cc418d4
> dev_item.fsid	ab2c88b7-be81-4a7e-9849-c3666e7f9f4f [match]
> dev_item.devid	1
> 
> So if you provide the original seed device the mount shall be successful.
> Which so long happening in the test case btrfs/163.
> 
> btrfs dev scan --forget
> mount -o device=/dev/sda /dev/sdb /btrfs
> 
> Fix in this patch:
> Make it as you can't replace a seed device, you can only add a new device
> and then delete the seed device. If replace is attempted then returns -EINVAL.
> As in the below changes.
> 
> Another possible fix:
> If we want to keep the ability to replace for seed-device, then we could
> update the fsid of the replace-target blocks. And after replacement, you
> have seed device but with sprout fsid. But then I don't know what is the
> point and if there is any such use case.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This is something Boris dug into until I told him to drop it.  I _think_ 
I'm ok with this, but really what I'd rather do is restripe the whole fs 
with the new UUID for this case.  Where did that redo the UUID work go? 
Thanks,

Josef
