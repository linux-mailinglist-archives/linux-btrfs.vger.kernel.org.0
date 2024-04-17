Return-Path: <linux-btrfs+bounces-4320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8D8A7B0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 05:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF2CB22671
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 03:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2638F4A;
	Wed, 17 Apr 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SyTmAtOr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lSbghLdi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87A8821
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324259; cv=fail; b=nC5nAxrVic3gRbbMO1t4N5ir3BRvEixZ4Zr5e4Tg/iiCJyDlG+L1SiYP9j2XNb/JW4sc2xhhkHwddBs4cB1kY17CspXQygjxuIW9Q9N2GS/SbvbaJcdFsfkyrOWVPljuyEUNlxL7n9GiS2J8NGprRjVsSuBSpnFnq7iKOXDCexc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324259; c=relaxed/simple;
	bh=CnIbuZwXSAoZs/W/3Hxg4rQofH0CLoJWhklhrWRMkj8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Azp9bcX+O0o6qbazGoRxiSUGO5wAOCGO3WvmQ4b45SW86RNYHHFYvQQKfKku1XtG5RxtV8Dmm+gcNUGLY0+eHc6dsgtOikJMUDAwmzHLaBy1X7Sk+LZRufPA79kRH+DzxRAeq6CAZiklVLKFRuEOcFar0YMvWv2cY6jrBe7i6z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SyTmAtOr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lSbghLdi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJk4mF014120;
	Wed, 17 Apr 2024 03:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=x02j8X+X6bV+DawzIOOjZ3eXTvrFjCZFY5cn8KRRj2I=;
 b=SyTmAtOrhXS0m9x+zFwkqidVjZlcZHurpd6ioP6c0a4Wrcucnl50tVPgwNa9mkt2kSP3
 fum6Q5o8OcZ6mciuv+xE9z5izozDVwkTVj2I9Vky0nlllyfG/s0XLNRKuJ7yqS7REwh/
 GxySS6FiUYSZrxz2oWMPvxpwjveO9c0BAuAt7OO5yrzA0lJzC8cPs37GIyNUBYyxLSNC
 4xkNeeVWg9gIalcdyZ7NPXjcS+m5wEpHRJdF1h8uI2L19fJIjPgCo9Av2+sBlmQHxFvE
 scmT7r3xIUfv5UYfbaxlrJ3hZXhfZ5ss011QiGxnP+6qNo1hd9Iz+g9rSdtm4pSlBHO6 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv6r2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 03:24:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43H2O5sO014374;
	Wed, 17 Apr 2024 03:24:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggedxgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 03:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHT5wofNcA05UlG7e6fP7480udbCVbA4k+kWPPimyM1jZ5wu5VNsoQGVUKHJUuDmDdQxcbfvpWqZfANexQSkWOu9bHfLfaxc1/DhxSyVzf8XtkuFSCf7DttT3PxECIqy1zYFSbQu749BID/eR9Iq6LaCJ52TpTP9fSZgtRZyJtRGxrdoYzGqMkHrmW1d05nWhnZIvemXH9orwXeanwpj/jIxFwe9IsTgzv5h4JPh3tC2vwqCdOzLCU9hNOYy53sS5HfnlL+gGMoeIBBXtdXgY0Xhaoh4X6/0C1i+aSDihb4EaAHjFd9lBXogabZla9bmO8Tzz/Dy4CmKAjJLpWqOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x02j8X+X6bV+DawzIOOjZ3eXTvrFjCZFY5cn8KRRj2I=;
 b=YY1twaR78lBeyq0E1CRNw/4ttTJkCF6kjTXPPU9RkwquFQXoJm7j0rZ8FUWoYbzFbprS9i0hDLPKvj099amewKUvSTiltJ5djc5DCc5f/fpl9YLckxssHllv9Q8DKZmav4xP0UpLKvSS8/EibbNuIdMYUG5WTBS0mG1RralH5Lt8g3t2tKvvTRnOIsM88rRZMB2dDSb08t3+l05auoKevl1NLbQRti5JzxD8J/E6pobNMH+vY/3GMSX1milcs/hsuGalSQWzTYGOGXlOyXPnXUqDjQZLiG7Sir8QB/f5j0HQGnFBY3YZxYoehuwPXzVLsYALFeNA9ykj0m+n663MVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x02j8X+X6bV+DawzIOOjZ3eXTvrFjCZFY5cn8KRRj2I=;
 b=lSbghLdiIBr7QBbnQ4LN7qntf9scFh8gP28ALFglHgFUAhadgV2QJaDGhALGwZtIXP3ozIOlpdTZMo77EohuU2FFFqN9PgGC+ztVbBza8ODByT/waSuxvb2AogJdzopqToRVs84p0ox0+A9f3cf0jKS85RfMbWWHSoFHEZv+t+s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:24:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 03:24:10 +0000
Message-ID: <a0daa2a7-b8ac-428f-bd46-b42e44c6a1eb@oracle.com>
Date: Wed, 17 Apr 2024 11:24:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2
 and err to ret
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
 <c1e5cfaf-111d-49b4-b927-ee140e83e5ca@gmx.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <c1e5cfaf-111d-49b4-b927-ee140e83e5ca@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 356490a6-f8e6-42a7-6fc1-08dc5e8dd886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0HCP7mp8zNbPrzndaIPEtWreLtFo4ogJw14ElIh0Ij2qrC3iVNzx3gwOsfDgmnsGyUDtq1NVTMqOwYWf+FpzGI6Q0x4+hnUBWfwsFaAHe9tVcCPoT744f+6Jq+J/NLNotfUYKbFhfDizV+mfnARquEupFYdVSKv8Gpo1hzQlxNG7pXo5Lz2zF/n63tQukV66yLbeLNrg987V8b8yM3h3BJ9SemdK5cSfhe7HVhEGhIGEtJlbGKfAv1J1H78xy+sRqOG1WpThNkgElkIyR/jChpk+s//i+YCh9BGgINXDPPNes7BkNZydKtGZ3ulC1dS3BRNWdlts/luFjSO2r6+ocy8LGA/OGaeCxR59dtJh/E2EnfmqpNeCnG7i04c6A4XglVBmA131/KocCIZwYf+WVTdsIbjy2XZgMk6YG8QV8Fmo3YBDTzAHhCUSIAH5hAQu9MCstFw4mpBHuLQs9DlHE6/C7BpP/eD71HGxZSkLJlb6saz3o1rlmTgDVYbZWY/YvI1mAUp8E5s32k5C2i/5a4WMkbDaUuymuYo2VuQohi1t9zCMHQuZCdvInK5Rt223rZqxq4sBTHUiBkoR69L64meuSFA0iBtggo1v73QWhKQVHlSfdWNll6o7FGuOmCJzbiv8wCvgaTUB+aHCVUlwmnnvHKoCEKuc3oqaYN+Oa0I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clpqMHREY3pUOUlJbEhLdmxsWitUMXFSU3dEWTJPU0NoV0dyRjkrYVlYaXBD?=
 =?utf-8?B?ckd0YzNmSWcvckNDS0xRbnp2RDNuWWlFLzhnd2RZcVJubEhiYWtKMXN1allx?=
 =?utf-8?B?R3hRNGoxOENLZytsZXBlZnlyTlRqa0N3aXRSWERnRDJIazhmU210U3d3YnMv?=
 =?utf-8?B?R1RrNTQxT0l3d0UwbEZpYm5WZXhpM3YrVGRVY0RWbW8rUy95VFVFdVRGL2dG?=
 =?utf-8?B?Zk41a1RvUjM2bVg0UG1NWWRZaHIyRWhPZGVtUG80cUxZTUlyQ1BnRXZXalRl?=
 =?utf-8?B?TCt6eEt4dG1QTEZhd0ZYSnpBQ0Mwa3V3Q096Ui9DeCtId2wya2F0NlVRZGdE?=
 =?utf-8?B?dERWV2FvdHdxYmVFaks5K05yZ3duREwyL3UySDBQTDhzZXdXQlJsNG9XZHgz?=
 =?utf-8?B?aUFMaEcyck1uR0ZnbGUxSkoyaXI4eVVYRUplZkVZYXkxS0EvTVZVMEJWYjBS?=
 =?utf-8?B?SFdVcS9pRkJHVDFkcDRveG9VRTVqR1M2Z0xHcmw2cndjQTJzNXdyOTdTVnZZ?=
 =?utf-8?B?T1kzclBid3dza25RZ1daUEJNR3FXcHJYeFVCdFdlYXRiWFBwdlladTRwaVNH?=
 =?utf-8?B?dHJ4S2ZXTldBMTZFbHkrSzFwUXNLaWVKVXVKNWo4WFNqckp2V3NvV1dXQ3pr?=
 =?utf-8?B?bS9wQ2FxNG1sSUpkVEFUb3NrOEIwbUtMNHV6ek9vRElXVkdhN0o1QzdDQzFa?=
 =?utf-8?B?eG9YT0N4QllhaGQzWkNjdGduOVJRM2dtSnlObkJtYUpUK2dIYzhlVjJsM0Rw?=
 =?utf-8?B?YlM4K3ZFOVRSNzBleVVLV3NqYTJNQThBZEF3Zi91T0txSlYycFhEcWNOa05S?=
 =?utf-8?B?a0tsQy9Dc0h4aGR1RW9MYkIydWVkNGRxZ25pWStSRzQ0SkJweHZUeW9rRnNp?=
 =?utf-8?B?dFFMMnRabjNaVSswSW45dS9XWFNxVGFyRHVQNHcyWVVrc05mUUUwcXlzN1pJ?=
 =?utf-8?B?SmtLb2h6bmh5Q1hMZG4ybEkzRFc3NTFGN1BqazM0ZXdEdHkwRU41N0Q2Mjh4?=
 =?utf-8?B?ditrUC81RTI4MmkvSnMremYwQysvZVVFN0tqZWF4RCtmMDhNdEt3Y2JiMGN2?=
 =?utf-8?B?ejJ4NSt6M3AySVhhTDltZXk0djJLRTQ4Nm5IeWJUUE5qbmwxakxYLzZMY1Mv?=
 =?utf-8?B?LzlQOFJwdXlmM2hzOWd6bFhWQzg5TGtoZFczSmd5aTk0THVuYUxGbWRKU2dJ?=
 =?utf-8?B?ekpjVHNzUVFaMi8xcEI2T1g2eWxNZ0FobGtFaFFoWDh2TnM1M1hGMktWYW51?=
 =?utf-8?B?VjBOd25jMWVzRTVyZ21EaW91Tk1kNWFMbHBFbkR1dXJxNVhqb043MTR0YmFO?=
 =?utf-8?B?OEMrNHVNaGdxeWF0dDhodVBNblRPTjlIdC9qL2E0aVVyV0ZSd3g1TElsWFl1?=
 =?utf-8?B?TmRPT2lZZDIzWnp1ejZSZjVJMmhqR0NwczZQMHQ2Vk03c0RXbUZjS2VGOHZU?=
 =?utf-8?B?K3gyNVE0cFFGQWhZV2xFOUFQMTA5M0xmL2dSR0Z6NDB5Sy9ScEVrcllVcE9V?=
 =?utf-8?B?aVk5aDF1Z2tyNVpsN0lIaG5Hb0N3YU5OQ0diOWlOellhTVArN0h6UU9McURi?=
 =?utf-8?B?RXpQN256aUk3SG5FanJ1aXNFYUgzbEltZG1wUURsR3o0NENHbXdiODdxeDFH?=
 =?utf-8?B?U1IvQmZ1anpJMTlEQkFIdGE4RE5GMFRJQzhkcEQ0NkV4V3pIaFltcHdmRmgz?=
 =?utf-8?B?aHhJc2JHWkFJNXRld2ViNWt6bHA2bVRTMFNycUo5ZnhjL0xEano0dHBURFI3?=
 =?utf-8?B?aEFzQ2wrVVNIZmV0dEJiS1VFeUNQb0NJdmw2QkVYYnRCRDFSeHJqQzZPNjYv?=
 =?utf-8?B?WkF5NmJNd3lVZ0R2Z3RaRTdPTnZzYm94aE16UllFVjhrQkZuenBEMkVwTnpQ?=
 =?utf-8?B?YlZXZWIxZFVyTWRLQ1psYmcweDErT1N4YzVsTFJRclk2SmxwdXlHbFNOZUJC?=
 =?utf-8?B?SFRDdHg2WE83eC92c201ZTRpRG9pTDJRVE13SUNOY1ZKOWxKSURva0xEUVdM?=
 =?utf-8?B?YnVESGhxa0g2bzZ6eWsycEpzWHpXTE5semIzUVVzdHJCbWVUaDd6ektHRHNW?=
 =?utf-8?B?dm9STFdWbnZyVDRGQ2RJS1Z6VjR1UmpvOEJnVEhoT2dGZjZ6dHZsQWF3TG0x?=
 =?utf-8?Q?QlfWjIyZVqCQeUTA8wqvLjfoi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fD3kYYXgNV95AaZzwEglfp9YUDobBPypqZyqv/dXb4CM5BQSnRjETtAygyqAWa8iN+LZ1JzL0VZ8+TJwwgAKCxVB/o4zfRNEhC61CvrA2jrNZn/CHbxYQKpkIt6w6i7UYcw5vIISQLPiWJ+z3i3Q99uyKIOf4LQxNJj4bz0vStKbffZmKiAw4NCHI7H4qQZn474xk0s+2kPDif+Pt4ZTLFWbZL4R85cBsEdlbl3+/wUCoOhK5sFGFCd22e/Yj+RzzLxNwa3ic/kAm2yq/b5lhokoR8zE1WTMQxkq/g3TpueH6Juf1qcK67r5G/US/ABCd5HYR7pE+NiFsd2cbxxBsQXD168a7hcJ3qFCyWYctOgkGhpzV+wFq5ZWExGESovlhWrY8sagJSCW0vkTM54LCrfk3dNjWSWLdyKHy/FqxkxE+vXh1+5whv3xLrYDsNunMN0rrSpJl9GNd81Uzzp9fCjeZbGij3Y772SYlBasTiaFDbA8L5X3e68jvP7pphFeftTQCnsNmGuFQAdczNUXJ2t7W0q23A6idjpxD3HWUry6TehdJJUqNXldRYsy2fFsNKHAtLs0rw+9vapyRsv3xHEMB1iFOcDqlonJSu7tlhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356490a6-f8e6-42a7-6fc1-08dc5e8dd886
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:24:09.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MSPLzjQPzta1pGp7wpztb8Pl+okQYiwogxTjpsfXnLMTwq95qkbSTtpI9pQAfn+mmUH8ogPE9USdppLZ9Jytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_02,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170022
X-Proofpoint-ORIG-GUID: gPiM-cZPpkHQYduBp9VJ4BCnGAFC2Kuk
X-Proofpoint-GUID: gPiM-cZPpkHQYduBp9VJ4BCnGAFC2Kuk

On 3/20/24 04:43, Qu Wenruo wrote:
> 
> 
> 在 2024/3/20 01:25, Anand Jain 写道:
>> Since err represents the function return value, rename it as ret,
>> and rename the original ret, which serves as a helper return value,
>> to ret2.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/disk-io.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 3df5477d48a8..d28de2cfb7b4 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2918,21 +2918,21 @@ static int btrfs_cleanup_fs_roots(struct 
>> btrfs_fs_info *fs_info)
>>       u64 root_objectid = 0;
>>       struct btrfs_root *gang[8];
>>       int i = 0;
>> -    int err = 0;
>> -    unsigned int ret = 0;
>> +    int ret = 0;
>> +    unsigned int ret2 = 0;
> 
> I really hate the same @ret2.
> 
> Since it's mostly the found number of radix tree gang lookup, can we
> change it to something like @found?
> 
>>
>>       while (1) {
> 
> Another thing is, the @ret2 is only utilized inside the loop except the
> final cleanup.
> 
> Can't we only declare @ret2 (or the new name) inside the loop and make
> the cleanup also happen inside the loop (or a dedicated helper?)
> 

Cleanup inside the loop is possible, but it would be something like
below, what do you think?


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2dc88f909b0..d1d23736de3c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2926,22 +2926,23 @@ static int btrfs_cleanup_fs_roots(struct 
btrfs_fs_info *fs_info)
  {
         u64 root_objectid = 0;
         struct btrfs_root *gang[8];
-       int i = 0;
-       int err = 0;
-       unsigned int ret = 0;
+       int ret = 0;

         while (1) {
+               unsigned int i;
+               unsigned int found;
+
                 spin_lock(&fs_info->fs_roots_radix_lock);
-               ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+               found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
                                              (void **)gang, root_objectid,
                                              ARRAY_SIZE(gang));
-               if (!ret) {
+               if (!found) {
                         spin_unlock(&fs_info->fs_roots_radix_lock);
                         break;
                 }
-               root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
+               root_objectid = btrfs_root_id(gang[found - 1]) + 1;

-               for (i = 0; i < ret; i++) {
+               for (i = 0; i < found; i++) {
                         /* Avoid to grab roots in dead_roots. */
                         if (btrfs_root_refs(&gang[i]->root_item) == 0) {
                                 gang[i] = NULL;

@@ -2952,24 +2953,20 @@ static int btrfs_cleanup_fs_roots(struct 
btrfs_fs_info *fs_info)
                 }
                 spin_unlock(&fs_info->fs_roots_radix_lock);

-               for (i = 0; i < ret; i++) {
+               for (i = 0; i < found; i++) {
                         if (!gang[i])
                                 continue;
                         root_objectid = btrfs_root_id(gang[i]);
-                       err = btrfs_orphan_cleanup(gang[i]);
-                       if (err)
-                               goto out;
+                       if (!ret)
+                               ret = btrfs_orphan_cleanup(gang[i]);
                         btrfs_put_root(gang[i]);
                 }
+               if (ret)
+                       break;
+
                 root_objectid++;
         }
-out:
-       /* Release the uncleaned roots due to error. */
-       for (; i < ret; i++) {
-               if (gang[i])
-                       btrfs_put_root(gang[i]);
-       }
-       return err;
+       return ret;
  }

Thanks,

Anand



> Thanks,
> Qu
>>           spin_lock(&fs_info->fs_roots_radix_lock);
>> -        ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>> +        ret2 = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>>                            (void **)gang, root_objectid,
>>                            ARRAY_SIZE(gang));
>> -        if (!ret) {
>> +        if (!ret2) {
>>               spin_unlock(&fs_info->fs_roots_radix_lock);
>>               break;
>>           }
>> -        root_objectid = gang[ret - 1]->root_key.objectid + 1;
>> +        root_objectid = gang[ret2 - 1]->root_key.objectid + 1;
>>
>> -        for (i = 0; i < ret; i++) {
>> +        for (i = 0; i < ret2; i++) {
>>               /* Avoid to grab roots in dead_roots. */
>>               if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>>                   gang[i] = NULL;
>> @@ -2943,12 +2943,12 @@ static int btrfs_cleanup_fs_roots(struct 
>> btrfs_fs_info *fs_info)
>>           }
>>           spin_unlock(&fs_info->fs_roots_radix_lock);
>>
>> -        for (i = 0; i < ret; i++) {
>> +        for (i = 0; i < ret2; i++) {
>>               if (!gang[i])
>>                   continue;
>>               root_objectid = gang[i]->root_key.objectid;
>> -            err = btrfs_orphan_cleanup(gang[i]);
>> -            if (err)
>> +            ret = btrfs_orphan_cleanup(gang[i]);
>> +            if (ret)
>>                   goto out;
>>               btrfs_put_root(gang[i]);
>>           }
>> @@ -2956,11 +2956,11 @@ static int btrfs_cleanup_fs_roots(struct 
>> btrfs_fs_info *fs_info)
>>       }
>>   out:
>>       /* Release the uncleaned roots due to error. */
>> -    for (; i < ret; i++) {
>> +    for (; i < ret2; i++) {
>>           if (gang[i])
>>               btrfs_put_root(gang[i]);
>>       }
>> -    return err;
>> +    return ret;
>>   }
>>
>>   /*


