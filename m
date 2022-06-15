Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391054CC88
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbiFOPTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbiFOPTP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:19:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C53EF3E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:19:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y32so19452886lfa.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uDvknv8d8riw/Fioa15Lo6uLbPdIIFNVNdkepeeWRC0=;
        b=Y2kKGclh4N754L1XM51nCBjKVsJxqeVeNqeTkR9obwKWfoqKQE9rpTDF1HxxnQd0ZX
         T1vnSlojo9Ud2+8wfx4eVYytiV5mcEkBINWeHmL04JwyFsYmjllXdjZdmcMZk0ra6L5L
         3vg06hy8TLPE370TShsFgxUxUULeTJYXdr2ojMYAphT1k4ELkFjD9NvhIk0ABnv6uN2O
         rpKri3K3maMln7KcFzdiery6Zm20/Jw5s1S4wd+DljSHN3XofuFohuo8bhslhjR3+Sak
         1K6ahpM5x7JicYPWbUFwRlwzihF6CA2RCnCIFNOG4gm6kXnfcsGFUgUNfALbzVs8/MtH
         eOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uDvknv8d8riw/Fioa15Lo6uLbPdIIFNVNdkepeeWRC0=;
        b=o5SKB3z/cuAygbZ20z+cjg0HL9wT9AjHmLxKq7KzFKFsXFYIsUZZSqCV6UjuTldAYm
         X/dt5ED7iclcBc/oI5v0PTc9DLqnS56iAqZgn0Ll/5AhcTLoiE/Fx7FDXf0wQ+tosEGN
         kMHvCTYjLCxUA4kZ/Mtsufi1adOplGZ+hejNDSga15SN57jGfVCcW+88BTXwW7cIKyi9
         QZf+OUbY6nmdozX6D350feUeO6IhwvcplD7AXC220RZjzF55RuNErvkG+NkRBvAczncb
         DKjd8677JHJi8WdaBkDej+rKdif7ezodOBiQEhWQWqBG71ff0qqioVSQp0UHqFUqQVrQ
         6LnA==
X-Gm-Message-State: AJIora91DYHTGSygASgpJOl1Sqd2/9rjQP4zAveBH+5k2bERsptpjDM3
        lB3eVPBrj8M+FdpEwKpvJQyo2nsN72bOZA==
X-Google-Smtp-Source: AGRyM1unm6YtPGS4qovOqC2lXh3T6B8i5MWjLy/grQV4rt1VHDPVXUfonHwtNN1IhyrDB0cQGF1lvA==
X-Received: by 2002:a05:6512:114e:b0:479:1e02:9318 with SMTP id m14-20020a056512114e00b004791e029318mr31425lfg.156.1655306352813;
        Wed, 15 Jun 2022 08:19:12 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:326:3fa8:c2fa:fd55:caba? ([2a00:1370:8182:326:3fa8:c2fa:fd55:caba])
        by smtp.gmail.com with ESMTPSA id s12-20020a2e83cc000000b002554673622esm1722154ljh.32.2022.06.15.08.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:19:12 -0700 (PDT)
Message-ID: <279f2c1e-52b0-3b9a-7427-147ce2271f8b@gmail.com>
Date:   Wed, 15 Jun 2022 18:19:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Missing UUID on BTRFS partition in some applications
Content-Language: en-US
To:     Jason Beazell <jbeazel@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+-mV7c_6Gu7VWKJcw9Tsr1BcjMTbHWNBOXpBwqVjc=vT4iuqw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CA+-mV7c_6Gu7VWKJcw9Tsr1BcjMTbHWNBOXpBwqVjc=vT4iuqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.06.2022 15:59, Jason Beazell wrote:
> I have an odd one that I haven't been able to find a good resolution
> for.  I have a partition that suddenly lost its UUID, but seems to be
> fine otherwise.  I can mount it by device, and btrfs check (cannot run
> now as the partition is mounted doing a snapraid sync) and scrub
> report no errors:
> ~# btrfs scrub status /srv/Data3/
> UUID:             1846f412-a17d-4e2e-b389-59fd9c7590c0
> Scrub started:    Sat Jun  4 13:24:32 2022
> Status:           finished
> Duration:         5:43:21
> Total to scrub:   2.76TiB
> Rate:             183.27MiB/s
> Error summary:    no errors found
> 
> Those both display the UUID, but lsblk -f does not and I cannot mount
> the partition by UUID:
> ~# lsblk -f
> NAME   FSTYPE FSVER LABEL   UUID
> FSAVAIL FSUSE% MOUNTPOINT
> sda
> └─sda1 btrfs        Data4   7a726017-4d75-40db-a90c-485f61209c56
> 2.7T    51% /srv/Data4
> sdb
> └─sdb1 btrfs        Parity2 207ea593-b347-453a-bc5d-fce2a9d4c609
> 1.5T    73% /srv/Parity1
> sdc
> └─sdc1
> 2.7T    51% /srv/Data3
> sdd
> └─sdd1 btrfs        Data1   73c4599d-9d6d-4e4e-9453-cfb128523136
> 3.9T    28% /srv/Data1
> sde
> ├─sde1 ext4   1.0           ff42a1af-db20-434f-b141-2ef2cb170e8c
> 36.5G    27% /home
> ├─sde2
> └─sde5 swap   1             4c37f7d9-7011-430d-8988-a5c003950261
>          [SWAP]
> sdf
> └─sdf1 btrfs        Data2   521987a6-f68e-4eab-ada0-9a3f265a1f89
> 1.4T    60% /srv/Data2
> sdh
> └─sdh1 btrfs        Store   2d9182c0-db86-4d8e-b727-abc594c8f624
> 1.2T    66% /srv/store
> sdi
> └─sdi1 ext4   1.0           ebd917ef-9f7d-45bd-b42d-31a0343d930b
> 101.4G     8% /
> 
> Now that I look at that, I also note that the Label (Data3) is
> missing. Snapraid complains that the UUID is unsupported when doing a
> sync: "WARNING! UUID is unsupported for disks: 'Data3'. Not using
> inodes to detect move operations."
> 
> any thoughts??
> 

lsblk normally takes information from udev. What says

udevadm info --query property -n sdc1

> thanks!
> 
> # uname -a
> Linux Moirai 5.10.0-14-amd64 #1 SMP Debian 5.10.113-1 (2022-04-29)
> x86_64 GNU/Linux
> ~# btrfs --version
> btrfs-progs v5.10.1
> ~# btrfs fi show
> Label: 'Data2'  uuid: 521987a6-f68e-4eab-ada0-9a3f265a1f89
>         Total devices 1 FS bytes used 2.19TiB
>         devid    1 size 3.64TiB used 2.93TiB path /dev/sdf1
> 
> Label: 'Data1'  uuid: 73c4599d-9d6d-4e4e-9453-cfb128523136
>         Total devices 1 FS bytes used 1.52TiB
>         devid    1 size 5.46TiB used 1.66TiB path /dev/sdd1
> 
> Label: 'Data3'  uuid: 1846f412-a17d-4e2e-b389-59fd9c7590c0
>         Total devices 1 FS bytes used 2.76TiB
>         devid    1 size 5.46TiB used 2.92TiB path /dev/sdc1
> 
> Label: 'Data4'  uuid: 7a726017-4d75-40db-a90c-485f61209c56
>         Total devices 1 FS bytes used 2.78TiB
>         devid    1 size 5.46TiB used 3.23TiB path /dev/sda1
> 
> Label: 'Store'  uuid: 2d9182c0-db86-4d8e-b727-abc594c8f624
>         Total devices 1 FS bytes used 2.38TiB
>         devid    1 size 3.64TiB used 2.77TiB path /dev/sdh1
> 
> Label: 'Parity2'  uuid: 207ea593-b347-453a-bc5d-fce2a9d4c609
>         Total devices 1 FS bytes used 3.96TiB
>         devid    1 size 5.46TiB used 3.96TiB path /dev/sdb1
> 
> ~# btrfs fi df /srv/Data3/
> Data, single: total=2.91TiB, used=2.75TiB
> System, DUP: total=8.00MiB, used=352.00KiB
> Metadata, DUP: total=7.00GiB, used=4.76GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

