Return-Path: <linux-btrfs+bounces-1677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB64983A947
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1175B225A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB94634F9;
	Wed, 24 Jan 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X+SHMlhK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZWbCqi40"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8D604C7;
	Wed, 24 Jan 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098250; cv=fail; b=VTGlVOf8hSSVMHUJBQjGVZwgdjU6J2EkHF2o9Tj9Dl27N6JO6miwXqgfc5P91QztqrTZs8DuCLpfT095HVVf71UU+NwavgJqwbAg/N+fzH7mbtBVRqcB+ZyO8lNkFNH6Jj+QmQ4Etv5Qs8v3nltQXx5sSHteGNAs5DnE3R28cDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098250; c=relaxed/simple;
	bh=4OhVwMeZbgUU40FjuJa8kkv+qTBjfy9d7A1KtJp7VgU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULCThyTSROOQ5pfIJ+SE/l2h4Bgnh0ovQdA3d8DMSgoAGz1RV5991ShDzKMKhuNdtk2qLEEZgtMOOSrrkN8sI26rlDP+zc27WkMOl8hVheQMn+9NCzyEgpgwUw7EdSPnltgTyt3Ho9rjoWeiJAz5s7MWbS8IAJaEi5wxbFZs6SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X+SHMlhK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZWbCqi40; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAws0M009421;
	Wed, 24 Jan 2024 12:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VazqlZ36djwKkjTEX1jkvkUAJT5nVzgSswvbknTj94U=;
 b=X+SHMlhKg8mAXV/kBEze3nn47z9UQPVGvvoImxPj8671ezOJecBK01wUKzozJv71XvD6
 16sLbav0Ml+gcNPDvhnyY/+20YD0M9O42ucwZjPLIEAepSCD5L9eZVuTxkUJbqbG47OS
 uR0pcoJsX2wEDjfD5r0KQXNjppptnP4TQdYveBiDXT/U3IxpkX7UqMi+Bh11vsuR9c84
 VS7u9OPJSCGg+XLss9rMJBU2VAzdbkiQ0cAhcgK37ZXHj6E37zN2W/Zz3dOQfO4uil+v
 FMbiatt/gfMaDwf7B7WEi97wmPGwBMAkNxqdu6F5NYbfm59pEz+jCjP6unM0h5Ga81pf FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy25ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 12:10:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OC8onJ025002;
	Wed, 24 Jan 2024 12:10:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372xqky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 12:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0uVRY5x9hiszuxIGmRx25PrYr1AhrBqnxrnn3Zt8mwqbrINpZT4CEQ+NYsbAcqiTSuiQfAssAQrR4eXs4IMU6SH1c73zZIw5KaDkLLTN7NlOHHHbubpUSexcd9ebmU2Ttu20TATL4JyjTM87eWndLg1mAtw3kiinJuVc3XHtQandece7x76nYa4Qa2G4ElnWHJ2SCv61EDxNJe12HMUhVdu5FAIcVTKPlwNMJMOmN9KacF/432+Ulo2EtuUL+4KezInnzk4y1nfpKknzRSzaqb7YF6YF6wOk/A8aytescJylCuCKXsyLl7JPwMWVXi4xvB8qLAYpXoBeuVXKUWoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VazqlZ36djwKkjTEX1jkvkUAJT5nVzgSswvbknTj94U=;
 b=eUHYTVWznWE3QyL4VKwKOepW+v+M/P7PYtoLkkGcbwLyw8cFyfJmxtQoL6dHp73R77huZSQkwDNa5+A+9BG83q25VAOAa6gw+DiHSynw7QsJi0KZn8F2Hx7y+WmSxgzQOddqYZRnMi+KYsxh7b7QwX49JHArRAo7H5METMA6ty67qi/UDSDZtwv4Ofyga5B+iBaLj1mT7hVuy7kv71vPbjB43ME+ELfYGSZ1LJs/UWSM+HE6aciYBlqv1x0Pl3VtdP93n6jkJGS9feIvrzv+fsVUk7dAmCb6vDFI8lyd1yVKDpPpOb9xmmfqpVqGIJNT3U55PNChZd8FhtJHBG4j5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VazqlZ36djwKkjTEX1jkvkUAJT5nVzgSswvbknTj94U=;
 b=ZWbCqi407qBstxtz6jimlxxFPGOB2QT8z4opvaKyITbWyUt2CHIT9RAiJlaA6IaGT3QNKpzAwiTpJrycaJmDWG+s4+z1UvoHW5GQiZhP3Q9RbXaSDsd3eoKV2ws3n1UxiMlcqwoLzWxcLHNIw73PP2iNZd0bRAw3WQr8xK4GjWk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 12:10:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7202.028; Wed, 24 Jan 2024
 12:10:40 +0000
Message-ID: <17e9c07d-9396-4999-8449-b0e3e764c32f@oracle.com>
Date: Wed, 24 Jan 2024 20:10:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240123034908.25415-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240123034908.25415-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b8f452-4199-416a-bc61-08dc1cd57b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hr7MmsZPcszdKYQtz0QBsMuzZOitRkdK4DTssVFhIcvw0dyPo3oYtPyf+qBsJzHkywYewzAut+5+abUlh9C60h1kB9TLGvBo5BljJQ6E4HLxXPQD/ys/8Dl8rJBPL/n2UIN5BNAcV/gD1UlVIByEIMhLGB9IsbqmDg0tBhP4svT9qyvkaSAqCos8V8ATF6Kmxveu7ceUzFXeIi7wuH6uHchkPkiJ0s6/tM6zeZNgm30twyTF89TmRN6JIaXhgQDSdCyo64X3EXX9PxL30LGacVE8lYOnwckSJTfeX4MEyIgZlrJePJ6vG9+CzpKmG4OQNGxns0mYW0YBmcMpSSyjJkF6/1nLmPuoFj753xKjQojqBG5gm/c/GWMy1n9lBXXt7P9N4UYMhwKQg6Tkru2K4KGOzkKL3cWFowParLzR1YSW30QEOoxT08iVZXGGHv/1Mf5zBE/fk2+BrPtYlNTLXjR1zutXEXYFtE1/gA3nYitzCz9zKPtwyXjVIDTYIi3lWGPWx8tRCx6CIgb1l3IjJOj04dZdtW+vu5fF34PBsXwbLbXrHuZBUwTmihxAPCj0h4/aolaSDMfTOjpBvwIwUd394E8TogYDy8W/Iot94Ycw2Il4M//+NzjGaAO27hJc13VRZB6lNbZAovXr0SFo/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(83380400001)(41300700001)(31696002)(86362001)(6512007)(66946007)(6666004)(66556008)(316002)(6506007)(53546011)(6486002)(66476007)(478600001)(15650500001)(2906002)(36756003)(26005)(2616005)(8936002)(44832011)(5660300002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUdSQlhHY1U3M2xKTUx4a2ZDTm40REZnalNzWmN1dkdJejR0RFdyOHB3enpR?=
 =?utf-8?B?enI5YWNyenAvTFhlczdpcDZKUm1CZjdPRWlOMnNoRlU4T2Z4M3cyalBtVHVZ?=
 =?utf-8?B?U1V4VUtYN2NTZ1FONmovaC9PWGtwNW45N1J5eDV4VmhzWjdOUGRIN0R2eDVD?=
 =?utf-8?B?YlhYOGN4UXNlUE4ySU9tZklMV051TlRPeFBiUlFKeURnRm9MamRTVS80cG1h?=
 =?utf-8?B?Qnh3MEl5SWhJcTJvcC9RRWRWZ0UrenN1ekxlZU4yT2I5WU51R1hUNlI3OHYy?=
 =?utf-8?B?bzl2OXQ0YlpPd2hEN1pOR0dUQkl2UVp6LzN1UFFCU0dyb08vbC9IM09QdW5y?=
 =?utf-8?B?OXc4ekdCNG9pRVJ1a1I0VlZOdXROM2QzUjJKeHE0Mm1Nd2JBaHRlelE0QmtE?=
 =?utf-8?B?UDFzVmNGcG83MW4ycDJDTkxLS1JwbFBMeVdiY2ZkSnd5R1VWTGpvWG9OWTI0?=
 =?utf-8?B?NmxscUdDY0w4R0srYmxRQkFENHZmLzRtS0NuaGhkVEZ0cGR3b3VvcGNoYXBG?=
 =?utf-8?B?SmR6Mkd5VzFKTFA5eXF4R2lVWjNiNWJ5c1VBSU1YblkvUVlSMyt4YW9CSkhH?=
 =?utf-8?B?WjVtUms3Y1V4azlMc1Z5cFk4bWw3RXNrS3VNRGNrMzVSa2dyRXk3RXhMUXUy?=
 =?utf-8?B?TDgwcCtkVXZPVEZwT2JmaUpZOW1kbCt3dEJQbmxoaVowQXV1Z0dGUk9qVEc3?=
 =?utf-8?B?TFhicE9VakphZmx3NzFMNlROdkFnSmlqaWVXY09oUkZuZnNJQ3NvQm1pcmdN?=
 =?utf-8?B?dGs0Rml6elU5VEFFYlR3ZXhWbXJ4UnFUKzZjQ25DS3FmRlRKeURGODRudTVt?=
 =?utf-8?B?cUtUUGlKdnVNQjh4ZU1SdkxyRmNLZW5jdXRIVXkya2x4ZldOYnJEWkQ5cnlx?=
 =?utf-8?B?YlhYdU9saTRuT2J5WTFYYktzdFlSWURDN3haZTQzUFdFZGl0TkZobk1aN0d2?=
 =?utf-8?B?bTlJUjU0Qm9jQURKSy9nTmlVeDlNV2piYjdDdGNpdUQrZWpvakJXcDBSaU1W?=
 =?utf-8?B?NHRxSXBaYWRJQmRYb3orb2V5SVRMRUNKaHdrKzl0NFMrT2dkN3YyOFlYQTgy?=
 =?utf-8?B?Q3BFUDhlc2dpV0Fqa1ZBL1o1R3NteTkrS3VkY3E1b2p5S3o0MTdZZUJXOTZu?=
 =?utf-8?B?UWRPMHhHSDVRZ3NjdDBkVWs3anNlUFB3ZVBUNE16aDhoSTlTZU1Xci9BVzV3?=
 =?utf-8?B?RlNSWXNoN2k2RCtTaEJ0Zms0NldrcFZMVWhOeWV5U0ZWOTJVdDN3UUZZMnhv?=
 =?utf-8?B?YTJhT0t3ZFZBRkpsRE1CUVBETjdydjlVZ01maTlMbm9nWDhNdWF1bTJUc3U0?=
 =?utf-8?B?SGFCWG9TSHJKMU1tRUtiNjArYzdXRWhLN3I0U0ViMWZjZ0gwOXdvK0M1K0dZ?=
 =?utf-8?B?ZnRialFxQnp5TzhHK1lSb2diekxnRVJBTFNMOGJjYzJGaGpqS3hCaGZtWVVQ?=
 =?utf-8?B?aE5CQ2NCQkIybzlYdHNKWkVhWlJRYW5vZWhKa2U2OTJuVmhJTkZMUkVrN292?=
 =?utf-8?B?T3V3d0dCeTFaTTZDbGhDemR3aGZ6UWtSZktxNWZ6dCtjczNzWHgvUis4czIw?=
 =?utf-8?B?WUZtSS9wWVBPYjBVdm9YRjBYbTBUUTh0Y1dWSTFoZHhySkZxQXhXMDgwQ1Ja?=
 =?utf-8?B?NTZHRGxnS01RL3RmWmxzYzhXajI3VDcvTjMvdFNDWWxwVW5zd2VJN09WcEdy?=
 =?utf-8?B?dnBwUU1WUlRmQTI1UU5UK2tYY2h2NmpnRklVbnhqYkluQ0NMRllWdmN0bThM?=
 =?utf-8?B?ZzJ5TGRRTXlzZVk4Qm0rd1ZMRjRubDFyQUJDYVRLYVJaZW1DWk9tQitXNWJH?=
 =?utf-8?B?clBySnB2VWFwL0o4amdYbTBCNjZIQnVWREJUdUsvWkV5QVozMnczQS9PcTQ2?=
 =?utf-8?B?ZWhrb2RZYVlSczVNQTJZV25SYXpwQWhWOEFpSGFHaHNsdzlWSWJyQUl6clgr?=
 =?utf-8?B?SE5WbjlCaUI3OVJNSzdzNEc3ekd3QlVpUExZNlpMOUx5WFhYbVI1UFpHTFk2?=
 =?utf-8?B?SEpVODJQc0xGbWJtYjdjNDVRWVczOHYxamtqUjRaTGVMZk5CbzNsNlYzU3dj?=
 =?utf-8?B?YmtOaGtrSkNFL3lQaU9UbUpRZ3VEVVZJU2dJak5QTm05eVFjL1Rsb2FsaDcx?=
 =?utf-8?Q?fEfKkj05weeROOhi6I7N7Znp4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rxAR5gCB6DiO9KyxrBIob8t/mqn21bPvG8es0nrxvA75L5TY6k+bjr+9gD4BZ0rs6l0oPlYU71wgfqe8RZOL+P5uddPpHHzbi6v1g9h5RaiYv7cSQqqoPweQJ1kZjfOzfIvpLVDtYDwTyImFdsZg3PKwinziAMVT9F1rln3SOw9I2ql8aTSseedWhvR3Jgr1WiuQsEnDsg21Xfq+f8qGm6UxjbYQHqwna8dQUhhVleq9r8XycBqPFVlqOFFLfo9jY2urWKGvvUBDYgxIwY9EJ4ULDqNJrT1q1uEYS8qPSOA8e4sge0q6tqdVllHYH7wJHBvnRtwWrzvGQn+8ZenliJC2RebZHlIeBcHcSbGQIUDtrOTHu0TV2BpeeOJoDxLVfMjfemW8gY9Vfji4n4EVT8vcAcmp2vnb9BbZprTSvBB3p9leK1cDTvjNUKZkQrlCsxG2/loc4jenk8NMtEb3+Npt6dkuXtwVs7sW06Qex2aYnTY1UDlzuu//hLPVZdT6ISWT8xqSPC9vh3XhnyOga/uH7b1Ckckro4IIsjqe0kt22+Z1tTRj/tVu6beY5j8xM2PQe9nSo/TlTAE+PEQd+vAHi3MtuGO3mbgk84iBOU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b8f452-4199-416a-bc61-08dc1cd57b6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 12:10:40.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqdxFHJ9crMvbXeVp9SWYFY3Dqc9DVrEOqBHghj73zAlJYuhFtg41B3ifPGJvSj459A8q+CwNmN2dZJfc25Ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240087
X-Proofpoint-ORIG-GUID: 64hMRxDTTHn5yEYq8heIn1XbnVbw1jvr
X-Proofpoint-GUID: 64hMRxDTTHn5yEYq8heIn1XbnVbw1jvr

On 1/23/24 11:49, Qu Wenruo wrote:
> [BUG]
> There is a report about reading a zstd compressed inline file extent
> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> content.
> 
> [CAUSE]
> The root cause is a incorrect memcpy_to_page() call, which uses
> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
> write beyond the page boundary, or writes into the incorrect offset of
> the page.
> 
> [TEST CASE]
> The test case would:
> 
> - Mount with the specified compress algorithm
> - Create a 4K file
> - Verify the 4K file is all inlined and compressed
> - Verify the content of the initial write
> - Cycle mount to drop all the page cache
> - Verify the content of the file again
> - Unmount and fsck the fs
> 
> This workload would be applied to all supported compression algorithms.
> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
> workload would result decompressed extent size to be 4K, and would
> trigger the VM_BUG_ON() 100%.
> And with the revert or the new fix, the test case can pass safely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/310     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/310.out |  2 ++
>   2 files changed, 83 insertions(+)
>   create mode 100755 tests/btrfs/310
>   create mode 100644 tests/btrfs/310.out
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..b514a8bc
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Make sure reading on an compressed inline extent is behaving correctly
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +# This test require inlined compressed extents creation, and all the writes
> +# are designed for 4K sector size.
> +_require_btrfs_inline_extents_creation
> +_require_btrfs_support_sectorsize 4096
> +
> +_fixed_by_kernel_commit e01a83e12604 \
> +	"Revert \"btrfs: zstd: fix and simplify the inline extent decompression\""
> +
> +# The correct md5 for the correct 4K file filled with "0xcd"
> +md5sum_correct="5fed275e7617a806f94c173746a2a723"
> +
> +workload()
> +{
> +	local algo="$1"
> +
> +	echo "=== Testing compression algorithm ${algo} ===" >> $seqres.full
> +	_scratch_mkfs >> $seqres.full
> +	_scratch_mount -o compress=${algo}
> +
> +	_pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null



> +	result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +	echo "after initial write, md5sum=${result}" >> $seqres.full
> +	if [ "$result" != "$md5sum_correct" ]; then
> +		_fail "initial write results incorrect content for \"$algo\""
> +	fi

General rule of thumb is where possible use stdout and compare it with
the golden output.

So something like the below shall suffice.

echo "after initial write with alog=$algo"
_md5_checksum "$SCRATCH_MNT/inline_file"

Also, helps quick debug, when  fails we have the diff.


> +	sync

  Generally, we need comments to explain why sync is necessary.

> +
> +	$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n 1 > $tmp.fiemap
> +	cat $tmp.fiemap >> $seqres.full
> +	# Make sure we got an inlined compressed file extent.
> +	# 0x200 means inlined, 0x100 means not block aligned, 0x8 means encoded
> +	# (compressed in this case), and 0x1 means the last extent.
> +	if ! grep -q "0x309" $tmp.fiemap; then
> +		rm -f -- $tmp.fiemap
> +		_notrun "No compressed inline extent created, maybe subpage?"

  workload() is called for each compress algo. If we fail
  for one of the algo then notrun is not a good option here.

  IMO, stdout (with filters?) and comparing it with golden output
  is better.

> +	fi


> +	rm -f -- $tmp.fiemap
> +
> +	# Unmount to clear the page cache.
> +	_scratch_cycle_mount
> +
> +	# For v6.8-rc1 without the revert or the newer fix, this can
> +	# crash or lead to incorrect contents for zstd.
> +	result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +	echo "after cycle mount, md5sum=${result}" >> $seqres.full
> +	if [ "$result" != "$md5sum_correct" ]; then
> +		_fail "read for compressed inline extent failed for \"$algo\""
> +	fi

  Here too, same as above, golden output to compare can be done.
  And remove _fail.

Thanks, Anand

> +	_scratch_unmount
> +	_check_scratch_fs
> +}
> +
> +algo_list=($(_btrfs_compression_algos))
> +for algo in ${algo_list[@]}; do
> +	workload $algo
> +done
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 00000000..7b9eaf78
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Silence is golden


