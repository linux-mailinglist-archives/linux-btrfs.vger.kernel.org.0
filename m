Return-Path: <linux-btrfs+bounces-3113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14360876850
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 17:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8002833B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE02D781;
	Fri,  8 Mar 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oUjqEuG6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lpkjibit"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C622C6A4;
	Fri,  8 Mar 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915073; cv=fail; b=t/ma4V9SxjcTIQ7Ja0VmGnV+kwR8PR06BmfFVtA89pgjLVtqaOqsfOu715gQBby2GU4MYphouQ27ETCVzqxYvMCi/8YuRyjCftjKawixcVjaUlX5xCdHvPG6QHedhSCCHjECtLoa0p8Cg0E9TQjrI5C/u3EWNMt9CozlK39ygG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915073; c=relaxed/simple;
	bh=tNEteNrfmMbgwSSOIsUgW44/op1gY54h8aED+sBdJ+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WfhYHQFUyEueOHwU84oBBl62rRUXRKoEJ1YuobgJLNvVr8tlBkpv1KKfAOgT8ZwPt163qHMKmj0jqbtObvhBdKK67SejSYIUiNRpd+rRrqd1MayEdihlczifB2oa5JeXzPlDc9XXq7EKyRFcR4msvKAZ5UYn3e/LwTyIcCubTAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oUjqEuG6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lpkjibit; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DThEf005327;
	Fri, 8 Mar 2024 16:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a/ivHJTD7Fgf0B0g6ZBMkQdYNLPRgxe3cI47mr/XIA0=;
 b=oUjqEuG6R0KCfdKqb/hJA8lur68ZthbfXFDEtWLa6/uVxLo/Eoq+iJEt1Iiob9hc+FdW
 jtVks7wDVnahA5sxyAvPyR3itwKLJF12JADankHhLqt5GWN2v76mlK/9SO3DKzRjlXpr
 KTFzYIaqkvF1m0D4uadOFL8G2kkfLgPsDKMfwc7V+ci7mRMr3ZIO5ebtSCxO4nib6wLa
 3b6KDSkonzi4P6OXXfhregRg8H/2gAWrQJkkKOYgYmORv6Drz8M/h/4A6+zTSFbmPxLU
 vfaShy91A2ZO0ExBCyrj0+LNa+ZMxsHmk3jI4jdRvV+Sw6ys7saSgZNl98FmPp0Y72Xy zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cpcen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 16:24:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428GBolu013793;
	Fri, 8 Mar 2024 16:24:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjct8h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 16:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V90qgc4d/LtHpfhEitZd+QAsdw9i+Uh1oKnPviuypYZI/8NHN5Jkoj3QrmBnu58ygcAze08rlJh1y5DOlT+/j2DDqTdVavYoOpLsH7P33bPfhQRM0DzCeeriOSOzwqo57zxCPcPQO0c6v8V8btMQKjeYLBurlMy4bDdWODrdK3TrgQRv+z5d3nHwxoZSnlNR1s4ID8d26fr+FMASs/LXBny27t96YAQPIjOwHCv+lCb4BXHozUssRBUvjh+ZkJcdOQ25wnIlsRYfQiFEe3fOJqyWmlhwqKPEAEW8NS+Hbl+lSzwkhVuK06AGx7FX5xcykGS5dN00rP2NeZsRcCMPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/ivHJTD7Fgf0B0g6ZBMkQdYNLPRgxe3cI47mr/XIA0=;
 b=eAK9/7LTQMWsFmSxJ0qOlzyl3odYQAhLbXUtWMTnQIrxvz3+qD3KjYJ+8/0SoLB6Chx+NW6eHdBPkzPuxKEX/6O7cKAAU8YJY5CUuGbsSTGRHZPX5onWD3TSAObd6Rj4DCuQTTAX1LN3UipQ2/5BkRp7GQTZmBzh27SkrGgb70sotjUi/G7ZijyDxRJNuKvYOb7uik2h74aaHeB4+9qGfhOfW6VVsN5Ca6iWL/COhYAMX1jGZ3tfvPx7ol0jOhDKjcCftJWZ1CzTiKRJr4RbDQJmOqp7MtmSAEREdsCUkT2wfIr9/+SlKRZuDOHJeIq4Jn0UhNovZ511oOp445+4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ivHJTD7Fgf0B0g6ZBMkQdYNLPRgxe3cI47mr/XIA0=;
 b=LpkjibitSJHKERE0uXJYv9d7nm88eqmDKiPGtGezcVjNEc0RveRk6F93LQ5Z7QtJBUBfAJyEfTQoJfrF+FI2B8ESQieC4WwnRRgTUW+7rioI7+uLxuuBmjBr3MWoMH1jMYtPukclcr4oNB08X2lfjcs1Uj/KG5UWgxbuYr2FRNQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7709.namprd10.prod.outlook.com (2603:10b6:806:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 16:23:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:23:15 +0000
Message-ID: <9a59cfac-2ab4-4c6c-933a-70dcd3e3d80b@oracle.com>
Date: Fri, 8 Mar 2024 21:53:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: boris@bur.io, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        stable@vger.kernel.org
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <ZeszQwa8721XnZsY@infradead.org>
 <be3571d7-2bfe-4bad-b2c6-84a0bf121140@oracle.com>
 <Zes4i3qvFk2nWjyY@infradead.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Zes4i3qvFk2nWjyY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dedfcf-6382-4023-a779-08dc3f8c0e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ird1/TTg3yFBLXzLEPn5VCvQxxnHHdHxL2R5ny0/eX4kxI1yLrUL3Ks3eKgmFGjCMUh6q4kf6qE28u61iWyNG9BdGEAliNIJaY5OOZY1eox/F0WuHRNIlLc/oeeN9/YaNAwcn4YnZNGqWmzwIFLSp6eiNSt3jgisW5WIQhR7+aJ5BTE0N6F+dGTKn/qRNLjjxUbbCJtvoVEZBFmHJAENjOcoEsu7DT1xCBRAHlzLYcIBYlIy3HY2PZTIyI2fhokmhIcArSULc8hQrlVc4XaU/2kgov1T0Z2gyNO8Qz/8uY4+2s2M/NKpspCBiDc6fuP+49noXFLU1OiDGjJ+p2cLays2oPUWLBGOGOICvTazUhG1/+gHWeGqiGN4cPA1G6Qzi6+Q/z+blMr+QN9huCdZamyygPDsZuN+AmoJpeutxUacPRDpXuQoBI6CJXx9UwxTdl6Bp3jJiCCA2+2oyz/T2JhKrXdiA/qQimpZVuwr7PiQ493NIfbAWS1vT3dpH2tDOuSfzefV9KaqNiONzhKNniYmiZQqD8mWVetB8AnN4RtrpXqvbvD+mYae5E6HmyQyi+3/u/48X0vmeawyyXiUkbC0Bct+v5gYAAIY4Yb215E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nk5qMW9HeWsrNWJBek8ybllSc1V4SWg4U01heXZoZjFEb2hGV3RiYWszREJH?=
 =?utf-8?B?cW1sNm52SmV3ZDZWRDB2N2p4TEJ0WmdTV0tQajFGTjErMU9ydm5aZWRXTWxi?=
 =?utf-8?B?M3pFOVdaekMvYWo4YUhzNDNwVmI0SThGRHo3S21wWlo4SmFwSC9yNlFCR0U3?=
 =?utf-8?B?Tkk4dFd0bEdQbVFtV1pEdUhRYUlhQTRlVXByUytUN1ZBdzh2YU5acTBURUNI?=
 =?utf-8?B?cU9vVklFVkVMRjE5TEFzL1FSdWpNOW04RkRUT2JjWVEya1prZXlPMXpFbFkw?=
 =?utf-8?B?dnZjQzBZQmNBTGdsTVQvbG5aZVh2bFB5dXE0SXdmWDJBUjNmMVJXaDVLM1ZG?=
 =?utf-8?B?Y3RDdU9GS2gvU01GS0VEZWVLWWZBaVFWY0k3dzdHUXJUVlBScTBLOUZMcUd0?=
 =?utf-8?B?MHAvZThzelFzdWcwVTFKZGNHQWN4QjJWUjBIOGFmNHNqRHFFYUJLNGxyQ2xX?=
 =?utf-8?B?d0NyWHROK0tuSktvOU11YzdleG5EOGo0bFFXTnowWE42RXM5NEVRbUJYVEI4?=
 =?utf-8?B?Q2Y4OEQ2dUc0MXJDTnpjTjFmSU8rSGVheFh2Sm9GUHBpK3liNGYybnh3NGs2?=
 =?utf-8?B?RDdQL0JkU2RKK0FqcWpFWUZmS0xwRXNaUEJ2VlB0bEVsbkR4Q1o5WnZoRTlQ?=
 =?utf-8?B?UnRWNFoxcWlLZm1OUU5YTGtBY2cvc2wwNUtHWVhud3A1RkR6TldIaWVpTllV?=
 =?utf-8?B?UldpRjdjYVp3RFRTMHkzS3o3VGZKdkFjQlk4d2RoVVhjcm5VZnl6Sm1EaUll?=
 =?utf-8?B?VWpwUjBaVlVqVjNsWHdIdkhXYnVqQkRVU1VtNnZiU0svbnF4UEN4d0xrOTBm?=
 =?utf-8?B?bGx3Q0NvbzBDQVBDQ0YyMHV4L1JZWkJRa0l3ME8xVCtpZUVtdFRBU1ZHZFgz?=
 =?utf-8?B?UG5JQzdoN2Rra2FjWEhOMm1MbFBJTXpPdlFBNFJMOWxua3orSWxUK0ZDMDRO?=
 =?utf-8?B?RjQ0UG1SaCtTSHo0VVBhb2Y3UW54eENRZ24zZ1Y2TmRtRzh1dk1JdDIxazA4?=
 =?utf-8?B?bm9lemNzdXFtOWp6WWRpeXJQMG1vTmpPTEo0TTJnR3FZcThoK2Y3UGZMcTM3?=
 =?utf-8?B?Tldzbm9jRXdWUlV2ZmFMcTJ2M0VRcXF3SDFuSTdKcEljMkRWUzVpNkdTejBH?=
 =?utf-8?B?cVlNVkQ4LzRuV293Tmt0YUFVOGEzejJlekMzTUsvYlRRR1VEOEVMMWpSRG5t?=
 =?utf-8?B?Z1JNb05ZSVp0anRRU1BYY1pCc2VUSkJaOE9PUFRueXU4bzBoYnAzNlo5YUZR?=
 =?utf-8?B?dWhhdEJSbzVNc2g4azMxNEdzQ3dhbkZqakZ0dlNyMGQyZHNqektDNjArZUxY?=
 =?utf-8?B?czAya3RSTVlvOUZ1MDE4NHRMUWthbE5LYjNDbFBndmdZK0lWYVB5TU1RV1Jr?=
 =?utf-8?B?dU9RbW9jZjVuWTJyQ1QzNVpTNUVhT2doa3h6SzNEa3hUS1RmUHhPSjViWGhm?=
 =?utf-8?B?a1E1Z3hpejZRMDBJZVN3V2lxTnhlZnpScmthanVZbktvS2pvUWZCRnBUb0Za?=
 =?utf-8?B?TTF1bmRMcExQOHpaN3pKdXUzc3RZNEdNYzRGMlpUVnVicGM4OW5TUmRnZ1Ny?=
 =?utf-8?B?MFB3ek5jVkQ1T0xCTFJZYldQZ2FxeVY2UlhwS3NpZEs2Q0VPemFiM1ZHWkJD?=
 =?utf-8?B?d1JYWVM3N0lMb3NEN05XN2Z5TWxhUUZGZW5KZTkrRlE4ZFRWUXNxZHFNNGla?=
 =?utf-8?B?VFpVekRpdHRkS2ZJMEVtM3pmSk44djVWL2VuQWtWS0VodHBJalVPVEhUaldu?=
 =?utf-8?B?aFYrV1ZGYlBKM1czUnNCK3VCNi90VUtROGgrV2J3VGZOTVJEYmdmN0JCbkdU?=
 =?utf-8?B?c0ZWQVk4TDBRVDJlVTZrMUJySWVneklFWUNHV2F4UTdsY0grdWRpUW1BcUd4?=
 =?utf-8?B?QTJ5T0N5bFF0ZWZLT2JuRTQyajhlQTJILzBJVjg3Wlo3Mm1heFU0S0ZQd3V2?=
 =?utf-8?B?L29haDRRWFdXNTlmYWZJMHdRU1VwRWhpYjhYcUpveGdzQjFyT1o0bkdTalFY?=
 =?utf-8?B?TjVpd2dJbWJNOXpVSm1Ja1dTaFJyOGdCdGp2Nmk0L3RiSUZwdnBNcHdOTWxI?=
 =?utf-8?B?eS8rK3d0alFOY21LM29WNUdrclY4a3VrWHRGNE9wNlBXQ3psdHZzSVJvZysr?=
 =?utf-8?Q?v+AcMWF2uqKhPd7CfffnOwNPp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CosFux+mzg2DUN1LpQg8ORTIM/k237q5MWMYvsKIRRuMPu26gMVykSi3EPOKZwcoVjkX0Q5oDfqcp0AeaCIbQCpVZGVRrCKMsXVghToLF/j355HUBpDg8Kpxf/2/sM30CPk1It4zzugO7nVANig21KeIdFMtfuOVTiffGvwUuG79iE1UWptPOVo2aexh0GdU12LJkHOgI21Ko5dKt4FXmhNQVWp1in2tcieeT9YMrwwehjvmnxrGVTuUwYCirq4kPFI3MwYs+WI9vhyd/C/OxBI7VOVh+bgQVllF6hbKN89siDetYJIiQPc5Qk1mPwjUFEbPs+2tSfE/Jg0RSLkSBBpFgk257dkZA4ThGmSqHSJhIR2TvgpekN8VOg3+jKZ+I344v0T7XSh+sYPPnev7hMfhvExvlP6I5/+2iKxuU+PMJTIJB92Q6MZHYACDOjhYfdv8wxF41GcgFLCBaL4JLcMb+ckFzXotLRQkrvLN82AUBAutufUaTPCzn8ha9Tfo8BpiV+txxz03dR16x0Ku5BaabdV3pfwYlj92b2SAuHsJaKDQuJhpuOyk5QDr6BAyxVaf8uxYX66Zorq2LFW/kR1KZm3Ky3r7DGh055l1SQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dedfcf-6382-4023-a779-08dc3f8c0e8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:23:15.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAluKIzdf7dFLYQB1+rrhoUbvtUSq1xcvRmGbjfYNgk28pjUxRgxdGpUlQ2TurvYlqNgz0Ot76e5VwHTOaxiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=921 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080132
X-Proofpoint-ORIG-GUID: 7HoJyy9ehitf43cJ4CVDNYk6qlU75GuJ
X-Proofpoint-GUID: 7HoJyy9ehitf43cJ4CVDNYk6qlU75GuJ



On 3/8/24 21:40, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 09:34:03PM +0530, Anand Jain wrote:
>>> bdev_open_by_path.  bdev_open_by_path bdev_open_by_path calls
>>> lookup_bdev to translate the path to a dev_t and then calls
>>> bdev_open_by_dev on the dev_t, which stored the passes in dev_t in
>>> bdev->bd_dev.  I see absolutely no way how this check could ever
>>> trigger.
>>>
>>
>> Prior to this patch, the device->devt value of the device could become
>> stale, as it might not have been updated since the last scan of the
>> device. During this interval, the device could have undergone changes
>> to its devt.
> 
> How can it become stale here? btrfs_open_one_device exits early
> if device->bdev is set, so you set up a new device->bdev and
> stash the just opened bdev there.  The dev_t of an existing
> struct block_device never changes, so it must match the one
> in the btrfs_device that was just initialized from it.
> 


It's a bit complex, as Boris discovered and has provided a testcase
for here:

https://lore.kernel.org/fstests/f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io/

In essence:

  - Create two devices, d1 and d2.
  - Both devices will be scanned into the kernel by Mfks.
  - Use an external method to alter the devt of the d2 device.
  - Mount using d1.
  - You end up with a 2 devices Btrfs with an incorrect device->devt.
  - Delete d1.
  - Now you have a single-device Btrfs on d2 with a stale device->devt.


Thanks, Anand




