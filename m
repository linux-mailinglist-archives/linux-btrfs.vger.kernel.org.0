Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DE550CB2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiFSTG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiFSTGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 15:06:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398BBC96
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 12:06:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g12so3670344ljk.11
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=scBbDIj9mWP3zB8XUjz5GUzyssFDDqJeupgEvITJjjk=;
        b=MPX9sJvUamTCz64DJfYeWd2v+9mn06CRemxBl6zhJSwyIr5X/KTdE5SnhfmcLaQrzb
         kIbmEMTXGAJKMHc2OSCrAmJSk9mOKfJcCzLY4hgY3yIoQAlJIj7NWL0wf76GLgVXPqKP
         TVKiY2or9CmQC4EO3sDXFWaP6HScgqfY1RHm6mj7Re/kLxhUTTU8QhrOcB+rMb/zURry
         e79445ByjFtTQMqfGKgnxQWY9jaAOyaB8bggW2JB4rP2fUy83EsTkn1RzwyhhTJyJuli
         c6rK8pzw7mnIlsnDp2FILh7QLSTuCWeNifJQ+cTxzLfiQqvxcVjv4bAdZjEe1OsyAnOl
         WUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=scBbDIj9mWP3zB8XUjz5GUzyssFDDqJeupgEvITJjjk=;
        b=f4SIylLJ5OoGKxMj3p07asFydPzUiX+ATE7I3FpzbPT+L+TlYkDRBt59/pkzpnW86n
         hghvnvAiJ1Z1na0vwSUx3U42f5RIpQZahKSG0cWENFE1rFN0GdQJU1SlKoFX9bkXmXu4
         2vQQMiVvN3/DLTl5F6JrkeSpjoyRDJkw4OIbu59I4bCBcpM1Nq83lDV2liUIt6bmtBGQ
         Jyc7MYGBMtZ+RxU8Y5dec3YQIW4tZNhqapDc1g2U5GJeyE7bhHaZRpyhE9Q9V3X1kUnY
         Myr5YssxszuN5tX+kCK5v6pOSRYSLns0Nrx9FhN76sI/GkuMNL51B1fGsoRk3kv1NzfY
         SzRA==
X-Gm-Message-State: AJIora/AeQzK0fXPV0o0ERpcj+KcXmRG6ftTItj5GechTdVgX5Vziexv
        qTa4eec0++RrTGoGIR54j7Y=
X-Google-Smtp-Source: AGRyM1vecv+pUtBS4+arQshXOjhfgLJYqNFyHndmFF3mVgXW+Uch4apwYVFzarLjg6BlFN/Q+7PVvA==
X-Received: by 2002:a05:651c:50a:b0:25a:65ba:9421 with SMTP id o10-20020a05651c050a00b0025a65ba9421mr3522209ljp.236.1655665576361;
        Sun, 19 Jun 2022 12:06:16 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2007:9d0e:fc6f:d534:bf54? ([2a00:1370:8182:2007:9d0e:fc6f:d534:bf54])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25cc8000000b0047dace7c7e5sm1453934lfq.212.2022.06.19.12.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 12:06:15 -0700 (PDT)
Message-ID: <cbc6be27-fa40-f5e3-657b-742e274dceec@gmail.com>
Date:   Sun, 19 Jun 2022 22:06:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Problems with BTRFS formatted disk
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        'Qu Wenruo' <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
 <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
 <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
 <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
 <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
 <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com>
 <000201d883db$a22686e0$e67394a0$@perdrix.co.uk>
 <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk>
 <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
 <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19.06.2022 17:15, David C. Partridge wrote:
> I can't "grab what I can" as I don't have enough TB to copy the data I want to save ☹
> 
> Does it make any sense to try:
> 
>  mount -o remount,rw /mnt
>  btrfs subvolume delete /mnt/@
>  btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
>  btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
>  btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01
> 
>  mv /mnt/@_daily.20220524_00:11:01 /mnt/@
> 
> or is that doomed to total failure?
> 
> The disks behind the raid card are all Western Digital WD4001FYYG SAS drives
> 

Is write caching enabled for these disks? I know that it is default for
some RAID cards (at least, for some profiles).

For disks behind RAID controller write caching is normally managed by
RAID controller itself.
