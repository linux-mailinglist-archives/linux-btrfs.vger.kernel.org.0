Return-Path: <linux-btrfs+bounces-12371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48DA67041
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F1C3BB8C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12018203716;
	Tue, 18 Mar 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhVYwBFj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L8vkdnWo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7941F180C
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291341; cv=fail; b=OLHEjLkTo1KcRZ07SGKh7hgsJyGjOsX9elYCDXdT+IRJHUh43Zzbk6ww2fO/9/GqJKoaadd1Wcs4SFHrLu0mgMXaR6+VeYmSqesT88s2SLqBUGZkLjLGfaeBp/n/UrZHHOx6IW+xKsWcrONwSTnWTzSa+H79NvgfUcMP9IeMwY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291341; c=relaxed/simple;
	bh=t0CNopZxwkEIPw6rFmMLqVezsQfZqhko+J8SrG6bSi8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXn+MH1z0kfPDEWfHZRcJiqH4y7UqWWWrMFLfvc+2US2mkqGidJVcl6BslWvX8R0iZvJgJJCV8gTIRzHzDcpmu+UyxCGwKqs9EWGEgEFqi8pKPuAyPnoMjnZhWLtS3z42diR0I0/neolK1pTb7n1v6WlKeACdvrlrxJUvUx0U3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nhVYwBFj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L8vkdnWo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7uMVv003143;
	Tue, 18 Mar 2025 09:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7IzeBfrpUgAKBPBcxeVVYd5Ewc9/S2XI1uAulHYR6aw=; b=
	nhVYwBFjeUv+6UyeHJm1LqW1ht15jN4s3FLrlNTX1ys18PRug0MxCYIgyJG2itpR
	reRHCuS2CGLXlU+fzdy8KPvoapQpVZx3rlEqIMf7wx0onVE+GWDApNVRI3KnkVLh
	ABVym25VjUbTmpAwrfnGNi+e5F6wmAno/GZ0FQ6C7b8GIEHHKbh//gcSJmqmLIYg
	S9OGVguilHe8/LwnjHOwLsvawpbsev2xVKvzDr3sxFnT+rLnMbC+FiCXDlNa8QUc
	jodGAhw+URrn82DKjGdM0sShKIfUiQI4rLcClyMy7zbiA2OpChCz/YVJghRvYjye
	mUY2etgEGtv3DmJ7j/tayA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8mten-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:48:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I85MmX009704;
	Tue, 18 Mar 2025 09:48:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxkyck97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y09B+4ON/KrGTBv5bueN/IqdxXO79FIMyK/HU9oDkeKslZhnXzkmIhiEvmI9C3jr7rYAdA8BW6UKnETrCvsEgw2ztd+Anli1fkjfHCf93iUciEWSKGPOiPK9XkVpHkuRGcPFZ1CN9nz191BFMVBVOTzixIP2rgWSq8XO8ESSjwW87HdqbC+NeojF9vxkLwguFCwkWs9E1WOgOtms4Kzaq/y17m9NAn+RbpB8yXmTRr5HLJrwOLUBa97EENX2PXTwYJVV9rRvBC7NTBlZ4xAX9EMUt7C54Pb+sJK1StGhFND7rR+jyhp7kB1S2gZqLoSTUnCAmgkwElxY5w4mJwe+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IzeBfrpUgAKBPBcxeVVYd5Ewc9/S2XI1uAulHYR6aw=;
 b=WPP4AC1ylwyPhJfquSmG4v4K972rcnvxTlP9EqDaZAcRoQBNeT4jn4CLMIaIqQohJG+72z1iTvzK/d5sxNIF5Wrt/A3B6rJEt4SHGFujJZqAx0yoFn4kOG9lOBP93q6D28QrOPzR+9m9za/FNyoT2N7nBHdUJObSNpxL3JqzyuDZA1mPZTgG8cJXc0/phDGiOkbYBn+zWBnXjc0cdkhUCZYFxnW88b2j5a472G9MiGNgW4nIU7DgVBHev1EmKG6SCMvDFIfOVf8sVRLdSb1U0Y/S+OJhkl5iYzmGOH/K8WaRyfRKxeLCUAy+h8ycfMChHDU1dRSKjd08G3659t4ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IzeBfrpUgAKBPBcxeVVYd5Ewc9/S2XI1uAulHYR6aw=;
 b=L8vkdnWoRWKaMozdxS/JHyegQM2Hh5XaBTzGFytOToZEUH91J0SfXfziNXtNtJGvZO+po6d0P2vVcVNRYQjQ2La1gY/qBGrUA8wBZnjDpjYhH1TEBG26BqiRc8EUpOTvQ5NE0u8/S5vqQOG/P7XU870AIFuHZ/q8FCeJAYI8mV8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:48:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:48:45 +0000
Message-ID: <925933d2-559d-44b4-b25a-5e952f051c0b@oracle.com>
Date: Tue, 18 Mar 2025 17:48:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: return EIO on RAID1 block group write
 pointer mismatch
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?B?6KW/5pyo6YeO576w?=
 =?UTF-8?B?5Z+6?= <yanqiyu01@gmail.com>
References: <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6d593c-5887-4000-465c-08dd660212cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU5ud0NmZm9ybk1tTTQ5TGFsTVZDMkZlNmF6YXRSNVZJUkZkSXU4NDA5MVhU?=
 =?utf-8?B?VXpocWlBenZRSFJMVEtqNlV6dU5LTXlzYlNPdkE3Nnp2YU1VMTNMekduQk9w?=
 =?utf-8?B?cXQ0VjVJQnluaUxnNCt3aXg3Tmo3RjBjd0RTZUZZQnppcDlST1UxOGhldDh6?=
 =?utf-8?B?Ky8rb3lkc1k4V3FTa1JXc0xSdzRNeGIrSUFFM0ZaeUJ3RXlwdVpxSm1SQUhZ?=
 =?utf-8?B?VitMR1dDTjF5SVUyVWdxNCtyTTd0WkJiV285dkVoZU5WYm4yQ1BHVFB2Tjcy?=
 =?utf-8?B?ZmJCY3dGSE9MaEJ2WFprZ09lMUNaSjRBVVoxSkMwSlhKZTNhZWNrcmxnNkZy?=
 =?utf-8?B?YjkyS25lMjlNa2FoLzN2RDdlRWZLY3REMXBablVBRlFQRncvcERuNEFwOUN2?=
 =?utf-8?B?S0pDNG1XNDEvM1Y3dlJ6M2JhMU1lSTMxUGQ3UGFsb25JRUJvWUwzQVhEME0v?=
 =?utf-8?B?V2FUSXBaakNZZFFkMXliY0tiTGs1aWJSbFM4OWpWQXQ3MEN2Z0M5bTdweklv?=
 =?utf-8?B?bW4xbGhDVFNLSU0yeDdZVFdXR1FEWWN6Y1gvcHc3KyttZVNVSEw2T3VYUVVR?=
 =?utf-8?B?WU1SRC9FajQ1d1J3UUNEZDRUVjk2NlRlSkZBcTVzUzhzWkl3anZGd2VIV2sx?=
 =?utf-8?B?Zk43RTdmMnFicnJDMXJGbnhqMXJhbXU4dVdwU1VVNkxtdzB3MzdtU2pUejNZ?=
 =?utf-8?B?OUh1ckpLeXczRUpueUFZektwSm1GeHplc3RQYW9nckt3NFFlRytqczFieDhv?=
 =?utf-8?B?dHVub1VGbWZPVXAvTENNaWl1cWV4cDF5RlFBUFVEV0R6TmFKNkMwQUdOckN5?=
 =?utf-8?B?akMvaUtVbUVYU0V0Yi9TSGFOeFFQdnI3OGNKbmZyWUxwRkdYU25vZUdHbmhH?=
 =?utf-8?B?Q3lsYS82VzVyc3Jla0pZZWhTd0hsT1ZKRlpLTDJ4YTlKa0ErQUh3R0JaaUFP?=
 =?utf-8?B?R2Q4djhZaU83VEpuVlg1Yit3Tkl3bkJ1UEhBTTFiMnV0ckRLbmYxZlBZanBX?=
 =?utf-8?B?ODFyNlZzN1RlZzRSSXBlZG5jdnR0a0lwQ0xVUzc0Y0JSR0pYeHphQWlpcFBE?=
 =?utf-8?B?THYyR3RndnYyRVNOdGdESDRpaUtralJ2amk2Vk5xK1VyUndtWkxlamYvTTJ4?=
 =?utf-8?B?bHpvcHcrT2ZPVjhWMFpZc3Z0bGNsTWZRSE5aYjJaK3JmQ1FlblNlVU14cGIz?=
 =?utf-8?B?b0FZbnFQN1g0YkNBdkl4d0JmV2k1Y09hUUxkZnY3MThJc0pQdmFUVUcwTzY0?=
 =?utf-8?B?cFhQc21WVWZ4L3RpUnZyZm9Fd2RaZmRISlJTektFQk9PanY4Nm53aGNQZ21E?=
 =?utf-8?B?bmpQUUhadGhUMGNoY0RlVjhtc0JKYVdub1NCdkN0RHJBRG9ZZU9DejJVRmF1?=
 =?utf-8?B?Yk9IRmxBblMzNElKUVIyY2J0VnVVcWRlR2hpKytFcm4vd0tKTFUwWTladHJQ?=
 =?utf-8?B?ZVJVR21heER1REw0dGgvbFdRVUF1MTMyc1FtK0ZEMGtVL0V0THJwd2hWY29U?=
 =?utf-8?B?WEwvRUZoL3ZHLzBZUlhJc250NHA0VnhYWVh4VDhqbGIrNEV3QnJRRWtEWDl6?=
 =?utf-8?B?T2VxSEptcm9oRG0zemxxQXIyd1ZDNVdNcmUxU0xXelAyd2NUbGIxdGVucHA3?=
 =?utf-8?B?aVg5RThVQ3hMVFl6QnA1bHQyN3ZLRFlYd09jZllFVFEwY3VvcmpQV0FJUjc2?=
 =?utf-8?B?UXY4YmF1Uk8yeG1KVGNNUzZ6MmYzYXZ5RzExRkZ2VWYvemY1S2RRQVNPL2dY?=
 =?utf-8?B?aTVuNk1vaTQrcUVySFJBRVBBSU9CZkdhYUZaZ3J2ckFMcEp3YUM0T09pM3Ra?=
 =?utf-8?B?dnFYaktSWWpXdS8xNUdHcjA4T3l4WWJ3WkRWb2J1QjVMNE9FQTJuRVRlL1Zl?=
 =?utf-8?Q?lVdDt50edPgrt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sy94enhuc1NtK3RFSGlpMjZlTDZYbU1RVnRNSGVzUGVMT1RwKzlWUXZoTHZ2?=
 =?utf-8?B?bHNGVWFGRTdRbERQSm1md04vOU1acGoyUW5iTUV6MExXTC9XaTNaWDlMdFFL?=
 =?utf-8?B?YzFoejh4K1Z3UDZKSUYrbllCMEN1bXdDMHRqeVAxc1FzOWJtcWNoZEsvUDhn?=
 =?utf-8?B?bHJEZytUY3RsYWNaUVMwYTNWRkV4b1NzbUtiMFNJenp2ZDJnQ2lTMG9QM1VO?=
 =?utf-8?B?UXNJbnc1UXRJdFNiLy8vL3VtU2JvMHhiLzRXV0lUSkVZUitnSHRhL1JrYjJs?=
 =?utf-8?B?Qi9iajR3Q1U0aFdRUXNuVFJoSUQva1I3TGljbklmUlA5dzV3bXRZOHN0UmJx?=
 =?utf-8?B?R1hwK3RmYmdDUEU5SUlpT0ltQUNTNjhIUmZSVmlEV1R6MElaZUIwV1FteWJF?=
 =?utf-8?B?aitnS2wzWWZUOC9GOEl4TnpyM3p0WGJ3T0pEQ3ZqSGIyekRreFQwMVlnRTFI?=
 =?utf-8?B?aUtNbFBUL0plMHR4c0FVa3k3R3NzOENPL0pIbmR1TG9qUUNob0VUSHFpNmVG?=
 =?utf-8?B?NU1EOERDblFUYWNiNzlaNU1aVit5bDE5cC84cEJBZ2RkZVYxME1nRWJGNTNU?=
 =?utf-8?B?VU96S0JXSkFadHhJTHhPZEwzcnM0MWZMWks5eHB3VnQzczlBV1ZKQkVPalcy?=
 =?utf-8?B?eWhtWTZ3MExxRTZqWGl5NE9PY1hzWkFkM3pZQ2VLTFAvc0ExRVM0UDcxUGRV?=
 =?utf-8?B?SmJsT2xvLzgvSnpJY0g3cHd4bGNpb3hZVFdwTUpiNkpCQkVMMng3dTlmenFR?=
 =?utf-8?B?RnQ2S3UvamhVVW1UVEd6a3dWZVRKanIrSzZ5NFJGdm5PUzFzejd2NlNDMjI2?=
 =?utf-8?B?a0loeWtsY01saWNjSTk5K3U0ODRFcXA0TlRIZ05FTnkrSmRyWGRoc25FYkVK?=
 =?utf-8?B?N0wwUnVxT2w5bjBrZS8vaE9RV2dKd3hMNkk3aVNHV1JpWkN2bC9QUGlzcXFp?=
 =?utf-8?B?bGtmNlRlTW5NTXk2NnpLZ291b1dNRGJ4clRLQ1lMU1FDZ2loV29aaWVJamtH?=
 =?utf-8?B?TUdFaDB6dk9tMWh3MTd5YVo4UEZhaWIyYWNjS2Q0SHBSNGtUcVlORVZTSVAv?=
 =?utf-8?B?QzIvam1yV3R0Y1JmcmtZMm1iY3J3eVRnVzFsUUFBR3N6RGhwWW96ekduTGd6?=
 =?utf-8?B?d05LSGRuaHowWTFVNlRrT09DVnVpdkEyZUZ3bkVFOXRubUdJZEtzdEZSbnBl?=
 =?utf-8?B?ZlRQQUd4VklIZnJieEZ4cGdmTm4vS0h1UXc2Q1djTzhVN0NTSzhpSEJ6M1VO?=
 =?utf-8?B?aXAwRkhhQjdpRXRheHVUTTBlMGhjMU8waExtMjQzNUROZzRSaG1hQ0JCWmc2?=
 =?utf-8?B?NGhIS0NSU0VWYWxBUWxTRnVlNnFrU3dCODByajkwUGF4RjJYRWFMNHVvOWlR?=
 =?utf-8?B?ZzY1empkYzQvL3RUeHpMbnRNSDlCT3RrUjZCaTA2QW4yUW4xdXhFOHpvclRN?=
 =?utf-8?B?dVBydWRCQ3hkT2lZRG1HbzVETFVkNDgrMTdydlRIN01vRHhvTEl5QklMMVdW?=
 =?utf-8?B?RVVmQW9VTFhqdEtiODRRZ0U0bE9OVTZiU2YxNWdWZS9DUURjZnVGVUN5MTh5?=
 =?utf-8?B?dG1wckZNMHBWLzZEdGoreC9aa3JUaFRIdllvbFE5SXcxZ0xkbHVJM0p3UGU4?=
 =?utf-8?B?Vk56VlR1UjdCZjdZY2p0dW1IdXdUNUY2cnYrb1YraHFDQzFjWmNDUWNINDBD?=
 =?utf-8?B?c1BkM3JqbjZtL29zakhtU3lOaERuekQ3WGxOZS9xb1ZMQnlOWDBKd2JNVk10?=
 =?utf-8?B?K1dXaVBremlaSnYzOHpXdHBuM0FJMHdQRkFKaU5tSWZuaFlCejZ4cTU4WnRw?=
 =?utf-8?B?dkpMdEl4OTYraGtXdFN3cGhsZ1B2cU5MUmVnMGpEUFV5dm0rZktuSHJTMjZy?=
 =?utf-8?B?UHdKT21CdnBhd0tzMThFUVRyQk8rdFg5TWRxcVltUm5POE81WGFCS3BEckVq?=
 =?utf-8?B?RjFKSllFbnRsOGtUOWxkQ3NYUWdQY3NLY2RvT1JrREx5WmVyU0owQTUzUU5Y?=
 =?utf-8?B?R0RjTDJkVWpEeFhCS0ZKQnFiTmZ5WEgyb3IzdERHdGtKRkJJZy9XTUJJUUFj?=
 =?utf-8?B?dGM3Tkc0bE5tb1ZSQ2JicjlzM3IyM28vZDZWc1RkTThHN1kxeG4xRkRucWZu?=
 =?utf-8?Q?qFXZKdVU2avlXOj92G/Qawnnl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	68RsQ9YLuwpBpfKE+oafNC9sHM3GmVtArLTzYi47OVN3f31pkPnzzUmXp5aWeP3r0rx8hR+W9AwCqG4R8FkoObHNnKh0zSGDYKz4cZXNd4wIP3srI6U88/bjOBBQQ+ZC8UDJEcHOigF2JlkPOful2s1CjfBJvEyXHl+NZa0No9ZXGU9tanIDl199aAuq7ASJhtK4opdwYBGyBSBtPA07x3h9zsvcXL3OLRfszEwOGOP3zRSMrzYDLOWgJkrKShiXPFqUmWK08a/O+9cPyn76dGzZ84EUvb2z5OsTNzy/TnKDywwRX6HExKCOQmmnMiU1WGvzl0UhswkSgipHrwV6Ec+Q95hEXhSBldjeSAqGF7bpthLSmTH2Cr6SoudcIaDFjZj5JhHo5iN6yE2KE3mMXx96XJn5mE9z+RI5kuY8lYZi+8b9m1rZ7ExraBw9R3bZ2xBH47yR/Rt3grGSETaY9Zdnxvjeh7Ds2TszAUgGzCf32LvhRjjIj60wAN5nE1zIcjCKayLfo0nBeA2P26F6rKkhwtAEPLTVW5oLfeo9QcGyK1kCKZlboQCp0NAU4Z6PBi6ya/u6bIvRUwMMZJ4seHtNIECYgWMxneZC2jzeXeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6d593c-5887-4000-465c-08dd660212cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:48:45.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOmTh4Noj/Vdqufpb/xYLZKUXIgz0yNWGQuDBEM3ZETELTRGPYDN9O9fFXXLIJmyttZvFQ9LyidYR2Cy7PRThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180071
X-Proofpoint-ORIG-GUID: Clcxx5FZA1g2hohWIxtlYrHWI9KPfkK5
X-Proofpoint-GUID: Clcxx5FZA1g2hohWIxtlYrHWI9KPfkK5

On 17/3/25 23:04, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> There was a bug report about a NULL pointer dereference in
> __btrfs_add_free_space_zoned() that ultimately happens because a
> conversion from the default metadata profile DUP to a RAID1 profile on two
> disks.
> 
> The stacktrace has the following signature:
> 
>     BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile
>     BUG: kernel NULL pointer dereference, address: 0000000000000058
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0 P4D 0
>     Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>     RIP: 0010:__btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
>     RSP: 0018:ffffa236b6f3f6d0 EFLAGS: 00010246
>     RAX: 0000000000000000 RBX: ffff96c8132f3400 RCX: 0000000000000001
>     RDX: 0000000010000000 RSI: 0000000000000000 RDI: ffff96c8132f3410
>     RBP: 0000000010000000 R08: 0000000000000003 R09: 0000000000000000
>     R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000000
>     R13: ffff96c758f65a40 R14: 0000000000000001 R15: 000011aac0000000
>     FS: 00007fdab1cb2900(0000) GS:ffff96e60ca00000(0000) knlGS:0000000000000000
>     CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000058 CR3: 00000001a05ae000 CR4: 0000000000350ef0
>     Call Trace:
>     <TASK>
>     ? __die_body.cold+0x19/0x27
>     ? page_fault_oops+0x15c/0x2f0
>     ? exc_page_fault+0x7e/0x180
>     ? asm_exc_page_fault+0x26/0x30
>     ? __btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
>     btrfs_add_free_space_async_trimmed+0x34/0x40
>     btrfs_add_new_free_space+0x107/0x120
>     btrfs_make_block_group+0x104/0x2b0
>     btrfs_create_chunk+0x977/0xf20
>     btrfs_chunk_alloc+0x174/0x510
>     ? srso_return_thunk+0x5/0x5f
>     btrfs_inc_block_group_ro+0x1b1/0x230
>     btrfs_relocate_block_group+0x9e/0x410
>     btrfs_relocate_chunk+0x3f/0x130
>     btrfs_balance+0x8ac/0x12b0
>     ? srso_return_thunk+0x5/0x5f
>     ? srso_return_thunk+0x5/0x5f
>     ? __kmalloc_cache_noprof+0x14c/0x3e0
>     btrfs_ioctl+0x2686/0x2a80
>     ? srso_return_thunk+0x5/0x5f
>     ? ioctl_has_perm.constprop.0.isra.0+0xd2/0x120
>     __x64_sys_ioctl+0x97/0xc0
>     do_syscall_64+0x82/0x160
>     ? srso_return_thunk+0x5/0x5f
>     ? __memcg_slab_free_hook+0x11a/0x170
>     ? srso_return_thunk+0x5/0x5f
>     ? kmem_cache_free+0x3f0/0x450
>     ? srso_return_thunk+0x5/0x5f
>     ? srso_return_thunk+0x5/0x5f
>     ? syscall_exit_to_user_mode+0x10/0x210
>     ? srso_return_thunk+0x5/0x5f
>     ? do_syscall_64+0x8e/0x160
>     ? sysfs_emit+0xaf/0xc0
>     ? srso_return_thunk+0x5/0x5f
>     ? srso_return_thunk+0x5/0x5f
>     ? seq_read_iter+0x207/0x460
>     ? srso_return_thunk+0x5/0x5f
>     ? vfs_read+0x29c/0x370
>     ? srso_return_thunk+0x5/0x5f
>     ? srso_return_thunk+0x5/0x5f
>     ? syscall_exit_to_user_mode+0x10/0x210
>     ? srso_return_thunk+0x5/0x5f
>     ? do_syscall_64+0x8e/0x160
>     ? srso_return_thunk+0x5/0x5f
>     ? exc_page_fault+0x7e/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     RIP: 0033:0x7fdab1e0ca6d
>     RSP: 002b:00007ffeb2b60c80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdab1e0ca6d
>     RDX: 00007ffeb2b60d80 RSI: 00000000c4009420 RDI: 0000000000000003
>     RBP: 00007ffeb2b60cd0 R08: 0000000000000000 R09: 0000000000000013
>     R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>     R13: 00007ffeb2b6343b R14: 00007ffeb2b60d80 R15: 0000000000000001
>     </TASK>
>     CR2: 0000000000000058
>     ---[ end trace 0000000000000000 ]---
> 
> The 1st line is the most interesting here:
> 
>   BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile
> 
> When a RAID1 block-group is created and a write pointer mismatch between
> the disks in the RAID set is detected, btrfs sets the alloc_offset to the
> length of the block group marking it as full. Afterwards the code expects
> that a balance operation will evacuate the data in this block-group and
> repair the problems.
> 
> But before this is possible, the new space of this block-group will be
> accounted in the free space cache. But in __btrfs_add_free_space_zoned()
> it is being checked if it is a initial creation of a block group and if
> not a reclaim decision will be made. But the decision if a block-group's
> free space accounting is done for an initial creation depends on if the
> size of the added free space is the whole length of the block-group and
> the allocation offset is 0.
> 
> But as btrfs_load_block_group_zone_info() sets the allocation offset to
> the zone capacity (i.e. marking the block-group as full) this initial
> decision is not met, and the space_info pointer in the 'struct
> btrfs_block_group' has not yet been assigned.
> 
> Fail creation of the block group and rely on manual user intervention to
> re-balance the filesystem.
> 
> Afterwards the filesystem can be unmounted, mounted in degraded mode and
> the missing device can be removed after a full balance of the filesystem.
> 
> Fixes: b1934cd60695 ("btrfs: zoned: handle broken write pointer on zones")
> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
> Reported-by: 西木野羰基 <yanqiyu01@gmail.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

> ---
>   fs/btrfs/zoned.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fb8b8b29c169..7c502192cd6b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1659,7 +1659,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>   		 * stripe.
>   		 */
>   		cache->alloc_offset = cache->zone_capacity;
> -		ret = 0;
>   	}
>   
>   out:


