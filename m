Return-Path: <linux-btrfs+bounces-3238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E233C879FB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 00:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A471C212BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 23:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5084779C;
	Tue, 12 Mar 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fq0qvAPl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CWiSsPhl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFA26286
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286378; cv=fail; b=cN5zGh+TjZxN4gEivaVM6T8LFbGypvRmgesVV9ssElOlcxhNRIWiW/QxG9aSsDK61P97N991QERx8STP2vIpAZ+FLBlws6ehdOPZ4GU1vVYNp5PReUt5DmnB3UouczY7L2iHaPyyyxE94KtUJEvPIti3hTiJGKlhoPMRtdmRnvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286378; c=relaxed/simple;
	bh=mMGnpZjBVkvOd/aryScBZXD8bWg9X5pgOljMjjMkzMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QCWPyNU0DP0NXxBKA/k9I88zbRsyc2byO7s/gCbYE0TFu5EWdLbmityqbVB2lMO813TddzQozDPSgMAvSOKnSF2Lnm0j0axXrOUkivrrAhX2ebtWOvPI5taxZlTzEz9uSWTXo84UivqIxHdoCjWAiLzDPykNJAd+OokGO+kbKJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fq0qvAPl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CWiSsPhl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CKQ3uc007800;
	Tue, 12 Mar 2024 23:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GllTe/RQgczMHmUno78j/do76J1oEdlSS6Fi1XuvkuE=;
 b=fq0qvAPltOKhPzGRKiJZ00leE+K+TI62R2j5eFJRclNZjsDsF67WUWYEw8P0lrvYFqim
 UIZt9sjU9hjX0tOEn5heIHR+aq2kgRPibYwIn7IxxZR+k/iPLLB4svhMXW9MyGFNoWhu
 vUAPjcSx33iIn0Jg8ha43xR2qUcj+yk5HSdxi6QC3ZyjC9PNhUIeKllSP5ohIWENIcXg
 +S+htK7LXHo4dLjNiuVf+qwKDWZqFPQxSlhZ0GDD6VDOU1Mbo9DmFym9L7dktWt3JSG9
 SzDFL5ydkcuIs96VuXeu6JMWNxR8qdvg7A4W7dyfad6ThV+CKjb4e6NLoYgKT3KaQjZV Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3ydpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 23:32:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CMTKq7019752;
	Tue, 12 Mar 2024 23:32:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre77xw2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 23:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3+sU3nnvZXocadfGt/UoUEACyfQztZIJN3uBPoP9FmPt5g1D53r6vyr9NW85g28+/jNqbLoWhpLDYXQz9SbD4GmdvdOh2ShlREjJYwxs6gWMPE+5nXM0R9ox7PRvOBC6/kYmo8jIZADUaQmXt7a1widbT5vJqcFhzzFfe962KvR2xGLISJ/Pm7aAIDQSLN6dgAWhuhzhdubINAuNEz1RKfhqUjrc409AsdO1VqYIBVuI7pw8C/dFFmDmI9vpDkjBI9VknwosW9BOCKlj0PshlyMUV2oZRSQxeC4i3oFyzPIBVOs1flUoSTOWD1ZefMVvDFkIOynR3pAbrUpyYNx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GllTe/RQgczMHmUno78j/do76J1oEdlSS6Fi1XuvkuE=;
 b=PMVC15mD8f5v6tOM/lWAOcAF0gceQOhgkdkmYld3WBdQ4k5GBAaZrKDkop6vaqb6Jt/KMwCkbqCtgLylqKO2bNBypHnPGEie/aoDX5PAO0P3Rk5eT12ytG6o52KLbJI0xUVA6HBmmhgWjquc6m6WMYx8gaxOVxC3Zlce24KKoeVmzyb0Km8eXwPVtvsKeOW7h4yZQlmvfyVZ4w1hNT2mKkxBNUohAihSztYPpkNDVRs6UVFUrjmBFq6xpwYsorzYJ66XBvaJlDRZXDr2AA9vI+Zsbzo2e6RPjg/I5TR4EHmBGph2TAf++gMZ29ynOvAf2JWGIhs+Rrgkn3hRJJ1B3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GllTe/RQgczMHmUno78j/do76J1oEdlSS6Fi1XuvkuE=;
 b=CWiSsPhlVOvm2ZZ90ijSOiftpLm/3udopq1uwqL5fko9Id0d1GN9S9DUaLErgq7qahROAJEFpVt9V38Z8pmci2EVhKi8rkTYjcAfZyyMuGE1iwyGmyFbu2PklG3YyBwmL1JOSJ8wTycthkq8cN5xDZLAufWM6KLpeqw2vc549yU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA3PR10MB6972.namprd10.prod.outlook.com (2603:10b6:806:31f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 23:32:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 23:32:50 +0000
Message-ID: <c87c39b1-04df-4420-ae82-81956ae0d063@oracle.com>
Date: Wed, 13 Mar 2024 05:02:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate device maj:min during scan
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <ea6a2384807500090943f95c164e9f6b899efc58.1710246349.git.anand.jain@oracle.com>
 <20240312191453.GA2898816@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240312191453.GA2898816@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA3PR10MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5b2ab6-ee15-4da1-6a15-08dc42ecbb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZXDnKdBJZN/uhJp30Cb0K1HwFWiH0GCj4Z+rg5dOs8E5urrutTbabf9fBG64u6VAN6rZ3NITgdGgtPDeWBS9i5JSzkJtme4cVw7Zl9EotqBiOwETezeKqyCH4eWtxiC/oO1WI1anNNs7kTZ51Xo9i/PjYv4zWY+b3aZNyMaD1o5zuWUJpIRgkO5N0fiN01Z3kJZzUbBsHgPEeJctYi15B9l/kc7LX1b+p3BzmP0ysq45uJsmUBpdM/pPDN3q703N39yDBYCwJNSUFSkvmByVd9+eoh2cwo8bHHmDnvWX8m6iiP/ZJ9t9ABmvahxH9Am/WfVhznZ6nw9fFAFRdePDPBL/C31XnEQDZ59GpVlS5E+h+tOVpI5B/ZrWB9BAbJA5anc1sErwewXqWVEfxDeZf1tPQ/rpvMNYhxBzvbYGnmKqCovxgNMy36ENcoci+88GDeDrzoegBBF+/VylcpSM5EVkoGFinZ1qyEz09RcOFUOHneTck+SRXKANmKruuZZFr9yDApgdkRiJeO+SAw4XVDfGrSj4mtphXGlMOxzfUttpvxxTzdzMB36HT7aHCy/L6LUowd3tl7OBvMepomx8JRTaUrQ7hVN4g8sSvlzIezns5y7SQU7tsWgoAUJC6RWvbPaATQ2ePj4KD7AbmQm5r7BlfUiJGtX1fUIhJ+LjY5g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VWFqWDMraUJQWnBVWWt2bnNDSkxvdWZDMDB0eTRZb3BKTGlMTjBrRXBYcm8z?=
 =?utf-8?B?WjRYenQ0dmlXdEZNREZKOVJQOE5NUjZjYy81RG1hV2xsYit6Q2N6blFLQm5n?=
 =?utf-8?B?RGlBUStiSEdQR3VEdUROMmRBemdJeTdBRHdrQ0ZEVlpEOTFhc1RiVURwQjJN?=
 =?utf-8?B?Q2g1RXR4cEFNamxzOXNOUjVwYThCMlRqSFFGeks2TkdUdFg1aEtCWWVIU1pS?=
 =?utf-8?B?YjFBQW4za3U2OWRsMnNGMG90MlpVM0JSS0thOHZLUTZ6a29nUVdIZ1ZRaEV0?=
 =?utf-8?B?SFZaOHhlTlZXT0t1WW9DYzIvN0pHQS9GU3NCRkZuWVcxbnY5S1JZU3BudHBL?=
 =?utf-8?B?Um5KQ05uUC9wMWJRK0lxU0w0QVRPY3lpaStuL3gvWXY1WHZqNnpJT09QUU1n?=
 =?utf-8?B?UXZTSWRyM1FnYTFKSjBqN2s5RDg0aTdMSFhHNHAvcEJ5TWR5N0dOTHI3UXV0?=
 =?utf-8?B?dVBOL0RaTG1ud1RSMFJRNzgrOXlJNElQYW9RTVZxK3ErSDVsOTJLbzlzRXg4?=
 =?utf-8?B?UjJ1Qy9wQU5WVER1VWZaL2VQSDRzYmlKSldSeXJOSDB0SHdFRmFrbDZucmV6?=
 =?utf-8?B?emZNWVZwSm5ieFRqdHE5TUJXc25sNmRCSlJ2Rm82cDVvTTkrV095eXoxeDBO?=
 =?utf-8?B?d1cvV21wdCtjTzh0ZmIxWWlsZXl2djhOYWFHQ3RpeWlNakt1VGVRYUpVSzdX?=
 =?utf-8?B?bHVYdjlRbmw3QXBpVUFSS3VIM1YyZmcyU2gzT0hvSStPT2svYk9aMUxwdWJh?=
 =?utf-8?B?TU9PSHdoM1pCMUI2WGhEYmNJTytWM0JOdEpHSUhzU1p2aWF6V25Ydk41Mk00?=
 =?utf-8?B?eTZ3NkUrekJVbWJaN3h4blltcmRyWW5vcDMrZUU1dk5XMTJ4WExjTnE2S1J4?=
 =?utf-8?B?c1RLNDZ1MHF4Wkg4Y3pkc0VBSjBNaDBVUEcyb2xkSW9RdUE0d0UzejlPMkJs?=
 =?utf-8?B?cGE0RzJFTTR0NTNtU0VwNFM1bUcvSGxSelRIcmZ3T21PTTlNM2RaTEs3L0Z4?=
 =?utf-8?B?cFgxV1I0ZTU2dHFvaW5GclAvenBFQjJXSGpRZ1dzcUFjaWg5NkVzNEw1cldi?=
 =?utf-8?B?TkxpZU9LVExFZUhFdzhkd3V1YUVObWJUNmNIbnh1eHFIZWJwZlhIdC9vZ0hl?=
 =?utf-8?B?K25sVktzKzRubEplYjFMa1FQOEJXZ01kV2NlM3BQZVV0U0RBL29zMmorMFc5?=
 =?utf-8?B?ODAvOTJmOGF5NG9CaFBDYkx3eXd4d1dVcHNKb3JqL083K29NY2lrZk1saWls?=
 =?utf-8?B?YUtDSG1nVmtBLzdzRlY3czdXSjBibm4raStkVXJBMjRvd0NOVUs1cHV0eWg1?=
 =?utf-8?B?QnhuVVBYbWVxK1ZreHZFNWdlL2dEbUh6YzZacWtCQ3EwSzFqb3hDYmZHdjF1?=
 =?utf-8?B?QUJmMmlwWmVFbllRaXFocVNTZlBnWS9IcXh3U0hZdFZDTXJmV3ZGK2w3ZWR4?=
 =?utf-8?B?ZUE3ZkRaWFhkdzhUc1pGR3BJL21uVUErVW93dHMrOWxFQUw4SnVjcldoTTdR?=
 =?utf-8?B?bGFNTms3VTZ3UUFsQ1VxNjlLdmJ0MzJoU1oxU2wvSnVJY3NHb3YwbC9tK09H?=
 =?utf-8?B?Rm5DcjBFYU11V2Nmb1VNR3kvTW9TSGlTWFo4MWZaa2Jodk5MdkNGWTg4enFz?=
 =?utf-8?B?bDFuTDZUVXlSbzVqWjlPdmpkTDV0UTZQMDJwYmRvNDJBVklnZktHKzJvNkxZ?=
 =?utf-8?B?RmZxcG1xa1lYVFRNQjl5UUNveGhjQTRwSG4xNDRJWW1WNEpEdmxLeGhoc0Va?=
 =?utf-8?B?eFhocmZBVEg3R09JbDNIdHh5VGNldUFRa0loaFNVb0xqZSsyNFJ2WEU0bVFW?=
 =?utf-8?B?eW1EOWRVYnVSUGdhSzEzMXpCZDlMaDk4ZFpvZGdsYzI4WDZMQmFGWGNqNWFw?=
 =?utf-8?B?Wkh3Y2FIVHIvQXNEM203OE9LYThxZWU1dkxwbUN5dmdWVU5xZG9xaGExR2xT?=
 =?utf-8?B?TS9vMEMvVHowYXpGQko2ZTNtamJlUEIzUktmbm54T0hYK3hHTTRvUElOWm1O?=
 =?utf-8?B?blBvWHA3UkdEVVFJZmpWdjZCOUtBVTVyTVZiTVpOaGMwYkdqdXpES3lFVUZq?=
 =?utf-8?B?SnFiV2VVTCtJK0lRajJNOVh6ekpBZmgzTm9tdnVWUmZBK3pQMlpPL3lyc1pm?=
 =?utf-8?B?T21QbmlHUk5NUk5pcHBLTFMwVHdSNDFoZm82ZE04eDVqRVI5NTBxU2pVbHdu?=
 =?utf-8?Q?p6M0LA4V+5s31J3EVaFESi/TPHwMNXSUqQBLE1mt+T7l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	stI6COnYwtytdijgiwsNHixNM/gmhIJNxlA1immF+shtw46M56mN8P/crVPw0Ztybt02AllKiioRkN+UzZ+82+4lKjX6eDxBx4GaCdQKNQujRSVQ7atP04HzsofMZlOKD3tiZxNYSlvCgrYtY61BlVMr/FzOl7kEzlcynM52PzbJFm8hscRX5f9pYKuv3bhDUc8jGzR9x2JPEYUt+BsPqQgiLctRQAYVH7G+qn+b+ZyBe7FmLtAK6wH8hgtE3ox8ostMdJ9dSrEyCx3bjgnvHHaO9prQTK+IivbVM36g4pTqP4J/AL4ioqczEdqfEg1+SaSpSuswfqSrsGcvkqre2ginyW6Tcv0JMFzl9JQw30bB2RzIfCFR5EQZbAs/+PzukjUTUZQkkqgJoR7fYIJYxiSXKFGRNEx8y7tWAwaV5+kJ/T5NJE8vEYgB3Ds67pLVfAZM55i0gdzaG79ChKrIpHdEz7naNANgD+nguEjb5q+uyE6shCnkYA6pp6WyKfudFnRmetO7rFVTibmaErGFaqqZ9EfjqstBWKsGdpvwXOfl/P8ETvqZgWzIzb4wCF5Wy8WI/XCshxegW1IrVf4H5b1gkr9KW9bXe/MlHmRXiAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5b2ab6-ee15-4da1-6a15-08dc42ecbb3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 23:32:50.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt/XIhBWn3m2OQridrLA8VBjz0KsgDSyfoNdeJQRt0UqZdEX0wz0jvWr3lFhyldJ2sPITBXNJhTItrrCnOy1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120181
X-Proofpoint-GUID: pNqbB5OYqHeIi6R9iBlcSUfdoXgqgFUV
X-Proofpoint-ORIG-GUID: pNqbB5OYqHeIi6R9iBlcSUfdoXgqgFUV



On 3/13/24 00:44, Boris Burkov wrote:
> On Tue, Mar 12, 2024 at 06:32:41PM +0530, Anand Jain wrote:
>> The maj:min of a device can change without altering the device path.
>> When the device is re-scanned, only the device path change is fixed,
>> if any, but the changed maj:min remains (bug). This patch fixes it by
>> also checking for the changed maj:min.
>>
>> However, please note that we still need to validate the maj:min during
>> open as in the patch ("btrfs: validate device maj:min during open") because
>> only the device specified in the mount command gets scanned during mount.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Is this a real problem you can reproduce? I'm pretty sure we can't hit
> this code path with single dev fs due to the temp_fsid logic. But it
> does seem plausible to hit it with a multi device fs.
> 
> If you can in fact reproduce it, please feel free to add:
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
> and please also send an fstests patch with the reproducer!

Hm. It is only theoretical. I do not have a test case because I am
assuming the patch ("btrfs: validate device maj:min during open")
is integrated, which means any stale devt gets fixed during mount.
So it is hard to break.

If you have any ideas for a test case, please share.

Thanks, Anand


>> ---
>>   fs/btrfs/volumes.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 8a35605822bf..473f03965f26 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -854,7 +854,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   				MAJOR(path_devt), MINOR(path_devt),
>>   				current->comm, task_pid_nr(current));
>>   
>> -	} else if (!device->name || strcmp(device->name->str, path)) {
>> +	} else if (!device->name || strcmp(device->name->str, path) ||
>> +		   device->devt != path_devt) {
>>   		/*
>>   		 * When FS is already mounted.
>>   		 * 1. If you are here and if the device->name is NULL that
>> -- 
>> 2.31.1
>>

