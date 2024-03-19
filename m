Return-Path: <linux-btrfs+bounces-3392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14687FD5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196631F2186C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582A7F48B;
	Tue, 19 Mar 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D6tNfLmR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NMscx8ZP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1877F7DA
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850057; cv=fail; b=JooN5XQf3vDZkJoJVWixIA8R3US/ncaYzICPHakGQFYhTIZZB3WoMGhM3b76k0mnly+CNY2kT+la5SaYzsvtOkbQMHgLbT6h+z5eLP3UfY5tv0PJhOqHUw/hNq+i9z2EiZPP5qiM4ecbu8fN5aW+PZSwqmjEtYejysaCmsCgJ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850057; c=relaxed/simple;
	bh=kObpx4DGHmGOnswR9nJZ3xbVxQBSFKH3rKlAMyihqNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYpPxbuYZ7toeMl/qAcN2yuiJ6YmUdxpHkPGPpJXG1h8Rxoi37B0nU7GX0CVUiEec9s+YxdMdNTlPUyRiKGK92wlS0Ua83+XBqBtqIt9njDBIFmRq0BN2Q410szE+7ot/eEZtR3KzxJPkCHA92/8A6zJQO8shtH7rphMoVRdWRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D6tNfLmR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NMscx8ZP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHag1013362;
	Tue, 19 Mar 2024 12:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XVtMEjKM3IDHbeCr4knqbcvZTZ8IM7QfKPysyAY7Yz0=;
 b=D6tNfLmRb/wPL8mHqHpDBRfcQLgeLZDt6I5QgQMplznGuJoXsnLd9QV9V79lUIuLNnF2
 zyyPkEMyRSbHrTiVK2jQzshpimilYJP/UpebaCRV1BFYIh4w1SJbxFSrEdFTbWgTn13d
 R6wCroxL+Rdi5DIZB/C1vJX+nVBhvEqX15PeCBzMvUVXAuInTlcknlyOO2y4mSi3gsHf
 IoBGpq1LQUSHpntK5rG05jQouLqQMpAp+heOAryR0PaTLed2eR+2gHquwNnvdE8yZxOg
 teb89VqAaI/rhJu3od54UwkEk2yZXkFWhQFE/sElkW/u0f+RGn5uAjL4FgpjQrA4XrMA Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1uddbgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 12:07:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JBcfBo003703;
	Tue, 19 Mar 2024 12:07:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v652a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 12:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcTbJXB/GmqYvFwSsauLdxIBQb3eMLW03bJGkbqpS7qPWP9LboMZdTodwvFEGI9Nz9fn+2mXYNtCTZuGvMVnJFwB+etbNGej1wy0SFUYOrga81ch7dbERAmmrZQ9SQJN7Rt2Nv2PPzdPFalr2sPEu9ymHEdXbN3NPyyB2oL6xgUEgDHvsykuvlO0VTJjNsQ9jERRJXofQ26ymJJagtkXOwjPC5cOgnDC8NZNlZnMee3RPyBHVHOraRy/GkP0RSfS1YOkk5noPcMAnGk18xiJb2JTnevTsXkZwbTBmC0pggyeESYUw/dluwBmBwG6JCabkrIHRHGl2Y+bwCo8dnnmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVtMEjKM3IDHbeCr4knqbcvZTZ8IM7QfKPysyAY7Yz0=;
 b=JmUzn/7aDTLDtn1nAJToMCphD4C929+bSjlCFletQqBY0s/9bY7ImqOfdNGUpNXuApGhdWzJhjuF4XLpvqeW8SXsKzwZrSt6tUgbNx+GkGKIoN5h9H3gXxXDVsahVtfwUIvukV0VYDQFLDHuR4hvJg8nSN8vtgOyvJhW6AM7hFLNgSHLwGJ4UOADMLPJgxulSfYw1iXrovnOwqvPmwj79F4ZG2JQJeS3J/0XUFYlh2dP2xvm7NFWlp1gDQoxw+c6O2eW0dFT2Hyr9aLREYXHm7VVwsEOEH1IqBRXKQ3oBVRPzgm2itv83jexK8f3z63iWfBuMX4unANopW26yzaY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVtMEjKM3IDHbeCr4knqbcvZTZ8IM7QfKPysyAY7Yz0=;
 b=NMscx8ZPPnDaOcL+x3xT7jPnhaukgGxdZYKO4Fkh6XSr200gBGLEEp7fydQHo70qRtAan1h5h5WhcKvG5Re0zyI4/vjsst0UX+fjdfx2eBZEtLizUmYPAzbNh3XGXzFwQEhNdyqHNGviKCbc7aR3rt2qQC8ru9M8vpYlkF6VH9Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7853.namprd10.prod.outlook.com (2603:10b6:806:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 12:07:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 12:07:28 +0000
Message-ID: <a94a0e5a-c67e-494a-b5d9-3b52bb23f7bf@oracle.com>
Date: Tue, 19 Mar 2024 17:37:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
Content-Language: en-US
To: dsterba@suse.cz, Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
 <0108b2de-56f5-4a7c-94a1-db415be8653c@oracle.com>
 <20240314165031.GB3483638@zen.localdomain>
 <20240318223455.GL16737@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240318223455.GL16737@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MUhOGay5w9/l2N2KfBOrfxhoMbIaj/A9zb5Fxwg8xB/YDzWvbjJEg7NTVDJubnbHxQZyEDWzfCFWqbjF14tkZvD4xTJUsICCNTj7HBCL5I5LKxK2oafEDL+lssQwO1iuEWkZQIMlNfNfReujjM3RLqkbgUvxD/w/ZexaCZfvEBLAUOYmlhfYb4WYSg65ponhtxQm5cR8fk4ikyoSiU26oyEm5oJ64FB7e9FKrOMa0QxFwlLKygadHKQ4AGB8l5dUKjyGSA46aDsn8nkrsDvJCR7EE4VITo3hu6ftaAnQ+PAZdscFbGgtp3f32cQ3yfkHCg6DknuoRXlPdVDh/19Q79CjIdL8O1NFQhqXTT36+78OL9fZEGQb/hEu0DXpxtMri6VjJAK82mx+l6GIcMtwIbFOriS7GfBXNx57Ehy+O2i8itMzkPOCadMfzU71Cswj2Oe0i6y8TeJwPVLA3SoqIwbnqk9kdzKB2K3RxDkUwFseDCQdGax4qdfsCP6It0/Ipa8VHnP/irS3d3/o624+VUg6ZLRIKCKlGSS1zE0/hZHsNUf7yXWrpW7/r5ECyV7N+0Wm1vkrqsFoapQiiuz99nJFjLqhmhrK9I1Jk71Ur2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0RqY29KM0xCUFExOU1WMmxJblpZZ3FkTjU3M2kvblB0K3pINmp3UFhKcjJY?=
 =?utf-8?B?NFduKy9OQXRjemIzNGVtV2FmYVBzUFhubURxRU5pN3llT3NaSDJBMjdwRW02?=
 =?utf-8?B?cE9FRFZ4eEk4WDVEZ0VTaEFnOUt1WUNBSFdmUWhZaFpBdzhrWVlCZWltVzZt?=
 =?utf-8?B?UE1JUE5zckZOaVFJWnFyMnAwbzh6aHVaZGoySjJNQThKem1VVEZ4WG1YMFR5?=
 =?utf-8?B?emFIYUt0N0FMNTkzUVJjMjRobS9NazZETzFyekl0VDRtL20vQlp6SDhEdmw5?=
 =?utf-8?B?WFNUalNPOElYWDNaYnVzc0JPS2lSVEx6cm1WOXM4bXEvWFRPY1FCRmUybWxY?=
 =?utf-8?B?MS92UTMvaEFzSmtsQVI4ZmE1aUlSc2pJKzVXTS9oM1BRTlZyN2EyMlYzM3pi?=
 =?utf-8?B?ZmwzbnFoV0JjZ2lSamVrNnkxeXJzcU5tL1padlBmTEVBU1gxUW1QS1VRbGt2?=
 =?utf-8?B?WEt1VGpINklQUmxZVGl6SzZ0SG9BV2RrRXMyQ1ZiTHBzckJOYVNPS3ZscFkz?=
 =?utf-8?B?VkUwcGJBOHduWTEyVUtXNkxMejA4WmxDR0lkSVkyZy9QeEZkSHZwY0JEOVdn?=
 =?utf-8?B?VFF5M2dPZmVEOTUvWFBRQzkva0p2ZGNXQXh3Zjh1WDA0NjFrSDY3eDBEQldC?=
 =?utf-8?B?d1NPT3R4SWEyeDBhZ1c1d3dIRWYwSE55TE5uYUVyaU4vWERjQUZmeU9OWjNB?=
 =?utf-8?B?UGZiVnJjZzc3a1htbVlJWG5IbzRJSmFCNENVWE9GdUtWVjhKazdvclg2TkFO?=
 =?utf-8?B?VTQvQkRPZWFLeElHdTg5YjVvaGlKRU9sb2N1dEszWnNwSjFyT2Iyc2g2c2s4?=
 =?utf-8?B?UFdYRWVNSDVyYUo4ZU90SndSaGJvYjZ0WWtrSStoMzRjaHdlWnlEbjZXRmQ1?=
 =?utf-8?B?cVROUGtqdnVoMHJzQ1lDbjJtZlRwZ1prd3pidGZJdnlGVnFLc2xQcTBORU1Y?=
 =?utf-8?B?ZHZjTE90eDNYR1BWN2Z3VlVsalZRWFdaejk0M3dtOVdGVEIyUFhvd0h5MmFV?=
 =?utf-8?B?QkgxN21LVlEwZFZ3di83ZEdrajR6RUdpdm1WUGlacnNaN1lPRTZjS1c3L2ha?=
 =?utf-8?B?RHhzazlJSHpDc0dqWXowVDNqakFoQVU1YVFGTTVJTmJrTHk4SlF5Ym9vOTdE?=
 =?utf-8?B?L2l6VEtmQ200ZXoxNFMzbFBXV0h4Wks0eHArdkgrRjJ0WG9wSzZaQURXcFZo?=
 =?utf-8?B?RlBhVTN2MDdDaittaWxiZThMUnVlZ05DSUcxS3RNREtUUFA1ZjNzMlN5enk5?=
 =?utf-8?B?dHpQWXkzMUVzbGFoVEFLbXhVenlNdlZtYktkcDJJWjZneG1hWVlxcXNyY3Ar?=
 =?utf-8?B?dHdhS3o5VTRvdURMelIvSU5PM2RtUlIrbzZwVXMydmh2Vm9oNytseld4ZnJR?=
 =?utf-8?B?WE5zUEVSNjhGOUw2MmdzU2ZveGwybi83L1lVdjBBYzBSdDNXMG1ZdVpPUDJG?=
 =?utf-8?B?L2UyZkpzVFV2NllwdzFaaXVCTXArWlZVVHJyQ3B4eWRBanZkT0dnY1BKcW85?=
 =?utf-8?B?TWh4T05VRVEzbjZFampCb3VXek12VU1OcFJnOVVtZmxUTVB6clFheFFsc1M0?=
 =?utf-8?B?V1BOQ2RZejJ5U0VuVHNhNTJkRlRvZGQ1a2lZNDg4ajhvUGZTWVpHcDdoejcr?=
 =?utf-8?B?SWNUVjJQT0J5SWtIOVpzUmJVeWxvWi9WT2ptMXdxYnFuUHVnZXpmOXZLMzEz?=
 =?utf-8?B?Q21WMUNEZ2h5Yi9JNzBsRndZMVYySTQ0UjFERGR5VlY2blc3R0ZhRm9zcVpF?=
 =?utf-8?B?eTIzdmY2Y1V6Mlk4OE42MDdMREVLYmozWE40Q01qc1RFNUUveXdWeXd1cE1Y?=
 =?utf-8?B?WXYwWlEzOXV6bDBxRlVwVDEwaHZucHZWQ2hhNVhzRm4rU3dxem1sa1VlYWVq?=
 =?utf-8?B?UytQRVlsZkd6Znpkem8rTkRyQXp5WHpzeDJQQWJwUVRrRjJSSFlqL2s4ZVc2?=
 =?utf-8?B?UmZnKzRPVXBGa2ZPKzNLTkVsSUh4YnNRQ2VPcVVJY2h4MW9DMlMyUFhKeTRa?=
 =?utf-8?B?a3IwRXJnMVdhT1c2WXVaeHFZVW5KaGI5cCtWWDIrcVlGL3laTG1wby9yRC8r?=
 =?utf-8?B?VWI4YW5KV00rbnc0WWs3ajVYY1VFNjN1NkRSdTVPZy9KN2ppQjBJUVpTdUxO?=
 =?utf-8?B?NzIzTE50ZHZCNUVyUC9XTXJ3dW1zWTBKOVppZ3VmS3ZPQzdMSHcrcGxVYmc3?=
 =?utf-8?Q?3a3E2XMVZnkDTVP8YeH5WIEE1XLndhMSueUwdGs4Gk53?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K/NwHk/vYTFDR5QfAxnhYM3AR1lW1mLoB15U/hPe9APz4UjhTegzpmlX/DAocZ3kfHfdDu6KCv5QmPodEBWoT88oc8HCcHYwr0NukyXVQ5XJCBu4KvXM8jP1QQV/KfY/qExolO6d6B5EeJYmo0rxx43zOS4pwHRPbLz0X1HhSpa+7VHsA14nmP6Vzv4Ja7DybI7IkO/Dawl6RrdwsSq81DSKOAafWgvwETq/3cbU+3CqIyFFk10EpQqf3BlSJsk5To1iYX96/IsL29dBW2ZsztUOYFNpdgLwsKCymEtqcpgXA07q4czj5YCcy/GYNi4lJ8AUEcIsz4As1+wjYWk3XMKedwFB1Fq2Oju94mJrjRn5XP2A2byNvZEcrIDv2RnQg6wydITj2i2RlGu/qpIJFDsx0DgbXcIBBVcYGrsZix32XuEHYvXPLoA/VdYEorHtfCHKXBU1k7fxLA7nh95qV1BDKUfYMmie+qa/yiW0J7ul6nMny1L806b1h4j3CYvIAjL1eV1+Gn7SZuJcFKAA9HQ9jc/fuXBiqAZE5Bfefcq0OTNVHVtP+FSvIAeA76lR88cTYu82pUSFy9b64dQASfsBdVf+q2ZxD4SGNLQztPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a104b5-d619-4fdb-32eb-08dc480d2554
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 12:07:28.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nVvUOVnlzL5FD7GGlnTAYK5TqMhuKevN7AGSKfFLVwx3N1mEuj2NWf5EIJWtaLG36l8Mo1ql7FBUZ+eO+QJ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190092
X-Proofpoint-GUID: pm26ONxQR7j2zmEaz-FdA0v_KKauoi38
X-Proofpoint-ORIG-GUID: pm26ONxQR7j2zmEaz-FdA0v_KKauoi38

On 3/19/24 04:04, David Sterba wrote:
> On Thu, Mar 14, 2024 at 09:50:31AM -0700, Boris Burkov wrote:
>> On Thu, Mar 14, 2024 at 07:09:24PM +0530, Anand Jain wrote:
>>>
>>> And this one as well, for the review. Thx.
>>>
>>>
>>> On 3/9/24 19:16, Anand Jain wrote:
>>>> When attempting to exclusive open a device which has no exclusive open
>>>> permission, such as a physical device associated with the flakey dm
>>>> device, the open operation will fail, resulting in a mount failure.
>>>>
>>>> In this particular scenario, we erroneously return -EINVAL instead of the
>>>> correct error code provided by the bdev_open_by_path() function, which is
>>>> -EBUSY.
>>>>
>>>> Fix this, by returning error code from the bdev_open_by_path() function.
>>>> With this correction, the mount error message will align with that of
>>>> ext4 and xfs.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> One small "nit", but LGTM.
>>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>>
>>>> ---
>>>>    fs/btrfs/volumes.c | 9 ++++++++-
>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index bb0857cfbef2..8a35605822bf 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>>>    	struct btrfs_device *device;
>>>>    	struct btrfs_device *latest_dev = NULL;
>>>>    	struct btrfs_device *tmp_device;
>>>> +	int ret_err = 0;
>>
>> A quick grep shows that "err" is a much more common name for the
>> variable when using this pattern in btrfs.
> 

> Well 'err' is there for historical reasons and the pattern we'd like to
> use everywhere is to have 'ret' matching the function return type or a
> common variable for any random function called. If there's need for more
> than one 'ret' (so the function-wide is not overwritten) it's ret2 etc.
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code
> 

> Patches to convert err -> ret are also welcome as it can be confusing
> what to use in new code when there are two ways.

I have made these changes in all the functions. I will send them soon.
It looks nice with that consistency.

Thanks, Anand

