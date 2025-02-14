Return-Path: <linux-btrfs+bounces-11461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB58A3590F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562763A5721
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638661F8908;
	Fri, 14 Feb 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pi/sx2uA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820C223339
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522346; cv=none; b=T0GQ2iro4bujBT74zNf8+rynpriGjt2U4fEC2GvbjtJ7fAWjUdOzqLU0x1cKCPGblpvDe2FrQ3q47D7xZ+V88O+52ekzTHCzjgRVhGEAone14Gw49miJXZWAEmn38PczKnMfgaAXSFGhsXGji7iK5+Zs/42uS4Yw6XnMc1w50BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522346; c=relaxed/simple;
	bh=jG31o/lllxWBKw+VmNaX+WgYRuGFI0yhHrfPrwedmGM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TcAxQufk/VjRD7RyFF+5S+n4F2/J2z52d2BXU0O5eIUCGroBvpKwWH4aFZJ26bSnvm2PVoY8nVw9RBzuDko7qWChLTP4Of3JzmtiEedHf8aCSqypMJWe4wUyEoKXWie/PSOh9mlkd8VZ0OZxnOhAtlMA/I/zKY4eHKCD4NUk/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pi/sx2uA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so648428f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739522343; x=1740127143; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpAd7sbjpOMgvr6s6bmiELEt1t5G1a8Po9RgDFpiV0A=;
        b=Pi/sx2uAiWD19BwYQquaVaVwZcux3HTereATRGpsdacJAIIQGETrmEjWiik5s/lYBO
         fJjX+QWkO/3IW7D0MaMUraSaGmIKe21uFCRY3MwhJQKM94/9cns8u9UR/MQdFPm24W8M
         2hGAKG6dFrWekt0oZr16FP4xrX3I0SC1JYabc9Fkzusus8/EvPJOr6MOuPugQx0SfrOp
         dp/vjfKYmLgB2X6XO4Bswx8fD595H6fvgA1kDxSwvSbI4LdA9u5elYlhrRXHGjBfu7Kk
         EwWxtnajh66qx2kHqOUPA9YcSMzVPXr1qeLEvEbBIipH5NwBbxdDwOS4etNjzQ4TwC77
         S2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522343; x=1740127143;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpAd7sbjpOMgvr6s6bmiELEt1t5G1a8Po9RgDFpiV0A=;
        b=VKvK75pABpyjkA3ve3JnL1T/zcz9ekAXQtiAkbrvrKSEaUGwreAb1XLLHnAinHE2G3
         5RIk2P0qbXfslR1yEfkGDesTBMdt1na9H/N9eiV+cK0gquACSc6CIAM0sAezQgoRDfu2
         vhJTJhlDfJcV91H0LsIXZ7iKz2OTIuu1n6RUNWJhg6fiqcLS3/Ufcwoj7iEMu60dF29W
         hYGxsw7prKOBldNQvxrAHKq6lexCyV8a0+5cg84oKJUKmd4T1dUuxxFs2KD3URG6ucSa
         5tPmgdbg/tcsTDBbZ1zjG87Rq427xFNhHpGOx/2L0cadg3XL0p+pm+7TOyIfwUC6x4n8
         MzZw==
X-Gm-Message-State: AOJu0YzRUYl3JAWaPOJXvZBrpOXOa6J7t9uTqEzVa2nogodd8/yXKTP+
	X1iRncX1dWMHibYbHWpzQnBrUeI5346P57MnpM98Iq6oT26R30pbG2aP7Mjttcs=
X-Gm-Gg: ASbGncv8iIT47nAq/fJJ8OYNF1vsToLoX0UNX9QxM7StisFLNNNG9eHJV1NrdOa629n
	RJZQ43cOara0q3cPfzKYcr3Fk6YMph1c5fCNw1esjroQTszp5ppykCsluW8RN0RujzNNkjsDAJ3
	27qEpOCqw6iUUfATYASonTcPPSpeMeOeQf7e1k98NIOIj5iW6PfMLyiNbtNz9XtV+G0Fjx8R8NY
	Wdkgcqz3tihz70CTzlztbu68xbPneS3gIl9mGRMplb02TK4opHlWyQJvl8R+YRiyOAfbWSM7Oe5
	rAXlEPzKXSKsK04rrbA=
X-Google-Smtp-Source: AGHT+IHgzREKdhu0Id0AG8HuEYp/NKLKKvJYSqK3NYt8hAUQte4z4eRH2+6zD0jl5LkCBL18dLj+aw==
X-Received: by 2002:a05:6000:1ac7:b0:38d:b325:471f with SMTP id ffacd0b85a97d-38dea3d0103mr10069562f8f.15.1739522342698;
        Fri, 14 Feb 2025 00:39:02 -0800 (PST)
Received: from smtpclient.apple ([195.245.241.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364390sm24582935ad.73.2025.02.14.00.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:39:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [BUG report] fstests/btrfs/080 fails
From: Glass Su <glass.su@suse.com>
In-Reply-To: <db20af73-0b5d-4327-9393-929173d4f91d@gmx.com>
Date: Fri, 14 Feb 2025 16:38:46 +0800
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <52F2C825-6401-4EFC-91DF-ED87F482A4E2@suse.com>
References: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com>
 <db20af73-0b5d-4327-9393-929173d4f91d@gmx.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 14, 2025, at 13:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> =E5=9C=A8 2025/2/14 15:41, Glass Su =E5=86=99=E9=81=93:
>>=20
>> Hi
>>=20
>> Recently I found btrfs/080 fails like:
>>=20
>> btrfs/080 124s ... [failed, exit status 1]- output mismatch (see =
/root/xfstests-dev/results//btrfs/080.out.bad)
>>     --- tests/btrfs/080.out     2024-08-29 09:10:14.933333334 +0800
>>     +++ /root/xfstests-dev/results//btrfs/080.out.bad   2025-02-14 =
12:53:24.667572260 +0800
>>     @@ -1,2 +1,3 @@
>>      QA output created by 080
>>     -Silence is golden
>>     +Unexpected digest for file =
/mnt/scratch/12_52_59_984815662_snap/foobar_39
>>     +(see /root/xfstests-dev/results//btrfs/080.full for details)
>>     ...
>>     (Run 'diff -u /root/xfstests-dev/tests/btrfs/080.out =
/root/xfstests-dev/results//btrfs/080.out.bad'  to see the entire diff)
>> Ran: btrfs/080
>> Failures: btrfs/080
>> Failed 1 of 1 tests
>>=20
>> It can be reproduced once in about 20 times on v6.13, misc-next(HEAD: =
1c08f86eeadab89e8f6ad8559df54633afb7a3ba)
>> in my VM with 32 cores.
>>=20
>> Configs and log are attached.
>=20
> I checked your kernel config, it looks like it has a config that is
> known to cause problems:
>=20
> - CONFIG_PT_RECLAIM=3Dy
>=20
> I'm unable to reproduce the bug locally, with 64 runs.

The test stresses CPU I guess reproduce possibility is CPU cores =
sensitive.

> But that's with CONFIG_PT_RECLAIM=3Dn, as I use that config to =
workaround
> the bug.
>=20
> Mind to test with either that config disabled, or apply this hotfix =
and
> retry?
>=20

> =
https://lore.kernel.org/linux-mm/20250211072625.89188-1-zhengqi.arch@byted=
ance.com/
>=20
Unfortunately it still fails after patching this.

=E2=80=94=20
Su
> Thanks,
> Qu
>>=20
>>=20
>> =E2=80=94
>> Su



