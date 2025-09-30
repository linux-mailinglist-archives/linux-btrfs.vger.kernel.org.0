Return-Path: <linux-btrfs+bounces-17283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37825BAB2A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 05:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E087A1268
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711E1D88B4;
	Tue, 30 Sep 2025 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ7w9lds"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27198F54
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204072; cv=none; b=NCwPsoHEAt1yIFw9CLNMh70nSVHPthJvGFwR+wJ6/7EePbwXOcFKV/6olXfVgZ9HWr0se693eMEP4+xqKqbaDtBMdzbMhnhHRoHtZG8jVlxFQJmGWxWB4i74yvpbEjM5tSsWBP5skrXjfZaoaemYByNRX05K9G9VCUPRCWGAWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204072; c=relaxed/simple;
	bh=zsDi7uslgFZ3sSKUmMd091B+OdYeBJygmTOMeEND5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB11H5DAwiTLMtPepjRa8PZzT0fD25WgJC1wox8FWLFaa5+MIAqisDOJyUj6emEoZEXJu6v/Cj0bqkqQhwOjWyzO+g9y/sDRQ7P/XFKZTVB8CVUbtyOL2nuswz/NhegDwFRl6lDQA+b0Bv7KoCZvLOUCAR/W9X4+9SxWklK5yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ7w9lds; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4e0302e2b69so16074261cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 20:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759204070; x=1759808870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le1M6VkoM8maBhpGpaBfI2kaslb6T3gdHrKqeP+njDI=;
        b=MJ7w9ldsgY9itc817U9s0ggvgc2HrTlrq8GTF+/Jzx4ljTTpIaBAPlFAM61nPVhnya
         58UtEA5CewRtVuv40sAl0i0mM10UPJetVlZMHipX3+k2RFDmtbyfT3E2IFJvT/TNXS+O
         RaqKCR/1qha9UmiaNgbWE8A2p3RwN8Gimk9x97Y53219SvCOma5JMbIb2hUlqzYH+3Ep
         WXYkbeCrJtS/69mdne7LwiPwS9ALBJ19SIdZ0g6BdD4t3rieOSA6A5JsZCh5/H5UhKU3
         /I8IixrvZd3C0+q+IljmlrvR+V49u+LDFl/AtQdq6NDdDHg2y0CAGlc/m0zxwjC/aWQF
         +7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204070; x=1759808870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=le1M6VkoM8maBhpGpaBfI2kaslb6T3gdHrKqeP+njDI=;
        b=ZnyhahERPjccTBn9VC4nAnY62IeKlJ8YQKPKTRWzO63bi2iIJbKv5MzSBPM1S4VWS+
         tXK2qRqHfoVEa7j9WYtmN9oCnmtvBnyFBjJ5WZVI/tBCc/cTSu3XWfpBlNisHUzsGXcd
         bXepRMH6LHWQ0QQfqkMbe1nEl1T3Ruc+YPlH2IE9RjAK8/yw9S8u4cQCaX2TJTryb4Oq
         KxmGQ7/QF9pTLScKUJ12qZDZ0637eN1dN/081frD15tAtPCapNgGNHPteMj9l1JgRWPE
         VSnRXra8/JrFBzhfKuI7MpWMUQlRzjTaqNPFAF/KEhBb/oKAqUsf3zzREHWGF+0KDHQ2
         izxg==
X-Forwarded-Encrypted: i=1; AJvYcCWRXtP0OH251L8qOTuzQa9dsrvklAysGsljLNf0MLVpMqX3nza4z+kvVxhm86K1/2rO8GjZ8n0aCHpKpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NzTwD+Q4NgWI4CwWvZu7y+uzgVASWnn5se9XFPgY5lKY2F62
	UyjVSQE3ek8QJWefF+asoSVuMgJYVTI4UKuJioE1ihcJSX09LPg+g59UcDFX6qKIyjMyESwk5RN
	6TxKvxEmtf7ENzs8K0r0dzKsUx2nLrPc=
X-Gm-Gg: ASbGncuS4B87iEKLOpJO/oGFhahAr3YQ3WXgqmxF7fk0Kbycq66dZ1mJ7QouULJOuJY
	dmS4aKfvvhh2CsrhBksHRzTbLLXsrHPGarRzLXdyr2V1+Y2LXSmd/eCHu25wUiMdZSLVXRqu1uI
	mpFKMG32GCKmobRUe8TX/Fgx/Jawb2iqmCWIZ7aewNw+XUcf6Wgm1bOagxt8ySd/ukrTNA3bVhx
	T+s+Isq0f+nmyOLIEvOVkk1o5nNl2SHzxzHcKVQp7ZTal1UJeTQ8lGPwhEIWg==
X-Google-Smtp-Source: AGHT+IHRn7wwofmckgetIFv7NrcubZxn6rGcrfJ0dYm+EeA9hAKHUc/yMdNYvRtWsOi0Pb8wklD9ICZ4GeMk/aZyVl8=
X-Received: by 2002:a05:622a:5144:b0:4df:fb58:b253 with SMTP id
 d75a77b69052e-4dffb58b653mr90163061cf.48.1759204069824; Mon, 29 Sep 2025
 20:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758148804.git.anand.jain@oracle.com> <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
 <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anajain.sg@gmail.com>
Date: Tue, 30 Sep 2025 11:47:38 +0800
X-Gm-Features: AS18NWCZGtNkWjyUPnubP-JR7Jk5LnsHQ5z55GYM6FNGTIys3gcBfYurna24xq8
Message-ID: <CANZP331iHxPpL0kQfwhzQrSkevs9KS8NF9cvcc-KNDUexM7wbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] common/rc: helper functions to handle block devices
 via sysfs
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26/9/25 23:57, Zorro Lang wrote:
> On Thu, Sep 18, 2025 at 08:32:46AM +0800, Anand Jain wrote:
>> From: Anand Jain <anand.jain@oracle.com>
>>
>> _bdev_handle(dev)
>>      get sysfs handle for a given block device.
>>
>> _has_bdev_sysfs_delete(dev_path)
>>      Checks if the block device supports sysfs-based delete.
>>
>> _require_scratch_bdev_delete()
>>      Test if the scratch device does not support sysfs delete.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 81587dad500c..627ddcc02fb8 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4388,6 +4388,32 @@ _get_file_extent_sector()
>>      echo "$result"
>>   }
>>
>> +_bdev_handle()
>> +{
>> +    local device=3D$(echo $1 | rev | cut -d"/" -f1 | rev)
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> basename $1 ?
>
> if you hope to make sure it's not link, you can
>

> basename $(_real_dev $1)

Whoops, not sure what I was thinking. There's actually a helper for
this, _short_dev().
The changes below will fix it. I can send v2 if needed, unless it can
be fixed at merge
time. Let me know what works best.
-----------------------------------
$ git diff
diff --git a/common/rc b/common/rc
index 627ddcc02fb8..085fab6e34f0 100644
--- a/common/rc
+++ b/common/rc
@@ -4390,7 +4390,7 @@ _get_file_extent_sector()

 _bdev_handle()
 {
-       local device=3D$(echo $1 | rev | cut -d"/" -f1 | rev)
+       local device=3D$(_short_dev $1)

        test -e /sys/class/block/${device}/device/scsi_disk/ || \
                        _notrun "Failed to obtain sys block handle"
@@ -4401,7 +4401,7 @@ _bdev_handle()
 _has_bdev_sysfs_delete()
 {
        local dev_path=3D$1
-       local device=3D$(echo $dev_path | rev | cut -d"/" -f1 | rev)
+       local device=3D$(_short_dev $1)
        local delete_path=3D/sys/class/block/${device}/device/delete

        test -e $delete_path
---------------------------------------------


>> +
>> +    test -e /sys/class/block/${device}/device/scsi_disk/ || \
>> +                    _notrun "Failed to obtain sys block handle"
>> +
>> +    ls /sys/class/block/${device}/device/scsi_disk/
>> +}
>> +
>> +_has_bdev_sysfs_delete()
>> +{
>> +    local dev_path=3D$1
>> +    local device=3D$(echo $dev_path | rev | cut -d"/" -f1 | rev)
>> +    local delete_path=3D/sys/class/block/${device}/device/delete
>> +
>> +    test -e $delete_path
>> +}
>> +
>> +_require_scratch_bdev_delete()
>> +{
>
> I'm wondering if it's better to call "_require_block_device" at first, be=
fore
> checking the /sys ?

There=E2=80=99s no harm in using _require_block_device() here, but I don=E2=
=80=99t
think it will help,
a non block device won't reach this place anyway.
config: _check_device() will fail for non-block devices.

Thanks, Anand

>> +    if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
>> +            _notrun "require scratch device sys delete support"
>> +    fi
>> +}
>> +
>>   # arg 1 is dev to remove and is output of the below eg.
>>   # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
>>   _devmgt_remove()
>> --
>> 2.51.0
>>
>>
>

