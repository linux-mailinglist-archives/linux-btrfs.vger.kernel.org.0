Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC28140193
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 02:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgAQBuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 20:50:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45141 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgAQBuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 20:50:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so21208697qkl.12
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 17:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Zhwq2gAuTNs3r2N8/oc9/2WiEZnfbNWtlYAFOCdMC5I=;
        b=MkJ+uRj7Z+JED2LZk2z1bNagBm1T6NuyxbWJUOL0MIDVUQq2SsmTw/YQa9Y6IPUVAK
         rPwIFv2BhIeXZFmGKlgtHrqqdCO0aIn8+X8s5Rn17l2Mz6vWYAzWclJGCZLH+/Wv2Hlv
         Y8InoSyBqtzvxmMvQrke6bg9TMfKLOILXXIjZmBKtZ+LWC0McdtEG1hhcf02YofGw70D
         wEjvz/YLqfOkaCulZWULv9LW8s/HO+5fr3Fv0bMLNW1f6LHtYmgdKFdsxgC1sfIZtOWm
         XKWh3Pz40EZ3VfpaQezePUkVTIvSaFGeLn7+zyn1EmnLUWAUbJEDHwDZC+4z5lfnvu2K
         r7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zhwq2gAuTNs3r2N8/oc9/2WiEZnfbNWtlYAFOCdMC5I=;
        b=T2y4Fsh7OINt71e6EOcLprfypPP4DxhkvK3O3Irbl+FFntj3Qzn9QZs5rYpzh0XSE7
         1nLrBy/cRTqIG7uCXRh5GRnEuHQLensCuSvS86ViDs6JddmPdxSKgGSFcZxvc9GkffjM
         rQTERCSzmfgyee4hVL3ceXiSHngVBrMCUJZM3YirkPgBWmiNZnfY/Yib0ZaKeZ6fYYBe
         zUNxrBWceBsSdFuDuIJpY9GaVFnUVR3fjRKicJP0/CIlNle0/xdZ6eCa/6n5Hqi42UI2
         3gxDrQ/95vQT73KzFZbNhDjc79LQuf2CWWJEHd1LoM4zzXBR0p8TjJsKcooXOnjqcGMR
         QYgw==
X-Gm-Message-State: APjAAAWuVnmgt95n+2qkoB9+4nHJaKphZ5Y6whHC2o2i/b9LbFhzIcPa
        bKF+RxYvDWS7cb3+kLDZg+95z82Tfaze1g==
X-Google-Smtp-Source: APXvYqzXrrsP1eVilRPkGnK2wKWe2rc/HoTQ8uMIjAS2xu24V+50iupasaDpOrWqHL7m/pVAO0ZX7A==
X-Received: by 2002:ae9:c003:: with SMTP id u3mr35086286qkk.133.1579225849069;
        Thu, 16 Jan 2020 17:50:49 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e8c])
        by smtp.gmail.com with ESMTPSA id 124sm11198370qkn.58.2020.01.16.17.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 17:50:48 -0800 (PST)
Subject: Re: [PATCH v6 1/5] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-2-wqu@suse.com>
 <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
 <3818d217-b64a-5f44-c80e-c49521bb3698@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4380a833-eb7c-cabe-3a97-9346d803873f@toxicpanda.com>
Date:   Thu, 16 Jan 2020 20:50:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3818d217-b64a-5f44-c80e-c49521bb3698@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/20 7:55 PM, Qu Wenruo wrote:
> 
> 
> On 2020/1/17 上午12:14, Josef Bacik wrote:
>> On 1/16/20 1:04 AM, Qu Wenruo wrote:
> [...]
>>
>> Instead of creating a weird error handling case why not just set the
>> per_profile_avail to 0 on error?  This will simply disable overcommit
>> and we'll flush more.  This way we avoid making a weird situation
>> weirder, and we don't have to worry about returning an error from
>> calc_one_profile_avail().  Simply say "hey we got enomem, metadata
>> overcommit is going off" with a btrfs_err_ratelimited() and carry on.
>> Maybe the next one will succeed and we'll get overcommit turned back
>> on.  Thanks,
> 
> Then the next user statfs() get screwed up until next successful update.
> 

Then do a

#define BTRFS_VIRTUAL_IS_FUCKED (u64)-1

and set it to that so statfs can call in itself and re-calculate.  Thanks,

Josef
