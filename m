Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB86A9FDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCCTFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 14:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 14:05:20 -0500
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78DB7193DC
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1677868862; h=In-Reply-To:From:References:Cc:To:Subject:From:Subject:To:
        Cc:Reply-To; bh=ej/dRCKQZW8RnQTVvULpRFLbPFVllOkUFcMm5YthgOM=; b=iKvLXDoTBDwNo
        S0qQ8tUrfPndDjslJX4M9S/Y3TyHaSNrqK0a1ZS9fo3Kz9Q4D4kS5+07zlkBbUL9ivcBgyPJH//Pz
        lQd09j/Elaq9Y262m3Wv/ysMh/wcxhAL+UbKLEEGRbjlslDiftCJuzyExHo5KX5JH4hwi2Ug9d1SM
        wZkmEFRmnvSAiQumW7EqjgAvOBzGKf3VafUoo1ivtcasXTOVBDxaBsvwWmTl68FeRJtI2z3hDMOJ7
        mBzbd4axRin+ba50YNu0ZHQQ+Lo1Y067as5ACl/yLt9hZtj/GhLpNute5jxESiPNjTB1ZVDwh0ZtJ
        LX1CGUDVUklWhJ6mYcPRQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1677868863; h=In-Reply-To:From:References:Cc:
        To:Subject:From:Subject:To:Cc:Reply-To;
        bh=ej/dRCKQZW8RnQTVvULpRFLbPFVllOkUFcMm5YthgOM=; b=VQ3Yu31LUMAb/O7AApqZ3w7A5e
        kjzFerONyIkl70daOnUAdaGNMvsJ+DGG4oFL82s7K8tFgAyB3uErC3JwGSdswdg+n3Uhi7dp3DbC6
        b45pvA8u2fLJFm0GXsHpdxgl4Fi9O3VXXNGKRJDLnVtVPlJX0hqE/3XoaYVseEEM4/d6Zq/WnXu5w
        hgxKmDL3W9E34cg6jiEHpbwpIR0/mHCD6CsVPVpjtVN9A3KnpPX8Ne6qBqYZuBS9mAb3zYs0FMqSG
        QHMRL0liJTqNpziYb3PKd/EjMefJpHlCSd6/pYWPg1kRBv+KQMc7q8LzlKeEdYgjcaclc86nHesNI
        fh0MZhiQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1pYAiT-000EkY-1m;
        Fri, 03 Mar 2023 19:05:17 +0000
Message-ID: <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
Date:   Fri, 3 Mar 2023 11:05:17 -0800
MIME-Version: 1.0
Subject: Re: Salvaging the performance of a high-metadata filesystem
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Roman Mamedov <rm@romanrm.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
 <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
 <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/3/23 11:04 AM, Matt Corallo wrote:
> 
> 
> On 3/3/23 1:30 AM, Forza wrote:
>>
>>
>> On 2023-03-03 06:22, Roman Mamedov wrote:
>>> On Thu, 2 Mar 2023 20:34:27 -0800
>>> Matt Corallo <blnxfsl@bluematt.me> wrote:
>>>
>>>> The problem is there's one folder that has backups of workstation, which were done by `cp
>>>> --reflink=always`ing the previous backup followed by rsync'ing over it.
>>>
>>> I believe this is what might cause the metadata inflation. Each time cp
>>> creates a whole another copy of all 3 million files in the metadata, just
>>> pointing to old extents for data.
>>>
>>> Could you instead make this backup destination a subvolume, so that during each
>>> backup you create a snapshot of it for historical storage, and then rsync over
>>> the current version?
>>>
>>
>> I agree. If you make a snapshot of a subvolume, the additional metadata is effectively 0. Then you 
>> rsync into the source subvolume. This would add metadata for all changed files,
> 
> Ah, good point, I hadn't considered that as an option, to be honest. I'll convert the snapshots to 
> subvolumes and see how much metadata is reduced...may take a month or two to run, though :/
> 
>> Make sure you use `mount -o noatime` to prevent metadata updates when rsync checks all files.
> 
> Ah, that's quite the footgun. Shame noatime was never made default :(
> 
>> Matt, what are your mount options for your filesystem (output of `mount`). Can you also provide 
>> the output of `btrfs fi us -T /your/mountpoint`

Oops, sorry, mount options are default with a long commit:

/dev/mapper/bigraid33_crypt on /bigraid type btrfs 
(rw,relatime,space_cache=v2,commit=3600,subvolid=5,subvol=/)

> Sure:
> 
> btrfs filesystem usage -T /bigraid
> Overall:
>      Device size:         85.50TiB
>      Device allocated:         64.67TiB
>      Device unallocated:         20.83TiB
>      Device missing:            0.00B
>      Used:             63.03TiB
>      Free (estimated):         10.10TiB    (min: 5.92TiB)
>      Free (statfs, df):          6.30TiB
>      Data ratio:                 2.22
>      Metadata ratio:             3.00
>      Global reserve:        512.00MiB    (used: 48.00KiB)
>      Multiple profiles:              yes    (data)
> 
>                                 Data     Data      Metadata  System
> Id Path                        RAID1    RAID1C3   RAID1C3   RAID1C4  Unallocated
> -- --------------------------- -------- --------- --------- -------- -----------
>   1 /dev/mapper/bigraid33_crypt  7.48TiB   3.73TiB 808.00GiB 32.00MiB     2.56TiB
>   2 /dev/mapper/bigraid36_crypt  6.22TiB   4.00GiB 689.00GiB        -     2.20TiB
>   3 /dev/mapper/bigraid39_crypt  8.20TiB   3.36TiB 443.00GiB 32.00MiB     2.56TiB
>   4 /dev/mapper/bigraid37_crypt  3.64TiB   4.57TiB 152.00GiB 32.00MiB     2.56TiB
>   5 /dev/mapper/bigraid35_crypt  3.46TiB 367.00GiB 310.00GiB        -     1.33TiB
>   6 /dev/mapper/bigraid38_crypt  3.71TiB   3.24TiB   1.40TiB 32.00MiB     2.56TiB
>   7 /dev/mapper/bigraid41_crypt  3.05TiB  25.00GiB 377.00GiB        -     2.02TiB
>   8 /dev/mapper/bigraid20_crypt  6.66TiB   2.54TiB 322.00GiB        -     5.03TiB
> -- --------------------------- -------- --------- --------- -------- -----------
>     Total                       21.21TiB   5.94TiB   1.48TiB 32.00MiB    20.83TiB
>     Used                        21.14TiB   5.46TiB   1.46TiB  4.70MiB
