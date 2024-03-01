Return-Path: <linux-btrfs+bounces-2973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B062986E667
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617F8289DD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D92744C;
	Fri,  1 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M/vyGC4L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YeFZiBTB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C132612B
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311682; cv=fail; b=ID+UG/bUF6ZQsV8Cao9ng+V/sl6d/zZnwcHVtMob7g4lBo7oUUO2JvquKrrmmi+nX4jqZzlsJSmnIYyFW+i0sgXMhIlPJBslfQNMgUi/T1fmqY/VfICXv6mJrEL5ekCl+6j5cxTa2f6GsM3EwwODH1qgZu409Ik8nTaPNDoO8DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311682; c=relaxed/simple;
	bh=H9c9Qcxh523/o10YV+LvMEmwGMoP3LS6h32ibR2JIBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oY/NnczjICPWymiVut0g7iC92i3z5dcgsOvrATX8Z7StEjVgcPCl/9wygeqXQIOpvpsA33mkRn64jiUO99dDb8Oy03OMrKhYg+0Of4L7IZ1yp1zE+uP24vcO/ocL4f9T67J1XT9lQDEjLgSIx7afTNMkQJKmtDWFh84kEV+4Tvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M/vyGC4L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YeFZiBTB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421GBdDt029769;
	Fri, 1 Mar 2024 16:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XdRTuDokSU7cYFNjNAu0JihVuxWE1hVV0tCcrFtJxGQ=;
 b=M/vyGC4L4upxxr0+9MN1m3pgTo9iHnc1BpJJlJyf+a4TBisS3eZW8T80L0oI8Y5rt7ud
 tlQP9G4qUECrOOmLY4GNSuJDaGvWgqd3kFBFrmEHuohWw2YVHeObITHhPd4CMe+lRQX8
 Z0vp56B1CcHlV5vkM22q6Nr1T7a81BX8KsS749rT8uavAT31SwN3znmks+wDdQ4poBLe
 lTBvFbaR3iJvSPq+WzsiA+cyIAXX3A1Tn+B0zqx/vxH+zDUow4tlctim010XEjiFaM1J
 T19TgQ8d3sYHKcJvLM9IoNWFRMZe0Y16zOVVC9n+NSjFuUNlqqtt8Bgi1VNcNlJha/jm rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784sgdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 16:47:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421Ghujx004784;
	Fri, 1 Mar 2024 16:47:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq82t0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 16:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpnhKjbxuipPM3d2EspUQF1XL2DKKzjRDMTKSeZhcjOOvBTZjxbXl60/kAgtHVo3jxT66/q2l6CCwRz0zlwCRtqLWctuKTQnppHZdE1HYcas2OzQUJ61GOidhlIBotZAmfah89B2LLsnHrRfo69M8OcbFh4122QmON3vCQ4GW7+T694pP+grO1Wqg+t/6dCSpM+mUgBrNsjAPP2SksAZ+Z7IhbKj+rY05GzrlNiBlNF8P69PBUyRuL2umgrbnah4VYZT6St9NptkXVhWL3oVUchGYj99ikGaVjE2/Z4Roh8dlS4VmRvYYLIjwagL4nvFEseZWF9ghzVl8yLaaqffjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdRTuDokSU7cYFNjNAu0JihVuxWE1hVV0tCcrFtJxGQ=;
 b=SeThg+6VFdbN//X/IHKLxjtyPOWtQrk+dLSgeYjMzAoVYaHaabsd/mEaiSjIF3hKKn9lv9PIP9HnsZ8FjfKfLuRltjba/xABlbYQ0wA3FR1eFAZoOzt045S6MAFkNlXg9lb9U/ynRO4xlCZnY1uF1WKYKDBXcn0tp3UFBfwqkHjHSB5vPsQExO4Q7QqlCnMZmqhFgDCennmyR5l560EXwKQAxSEORlgiEWi30hYtD6Avg2CeLkwgKJSPoxfi2HGqfmQL7GaL+KGh5F3Tzmr1lwku6ysl7lS6kjkdKQERdro5yzFgSD2kbR28FcW2FGuwDQI04rH6aQQeuNdHVZoUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdRTuDokSU7cYFNjNAu0JihVuxWE1hVV0tCcrFtJxGQ=;
 b=YeFZiBTBQG8Q1/1fOkCNulJuCwWE13Y5OMKgR+7JsK2XZhek7ZHLfnkNlBqo0q9nfkxDSYg2JNjlJ1kMYyZ17oyYGzBVfG/6c0/F6Z1sJONaf6EfStX3OW2IfA1r1cPsCoKfYDVxns3h0pMRJhFs7rN/wPBwgoGRpPqAZnpxzOA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6392.namprd10.prod.outlook.com (2603:10b6:806:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 16:47:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 16:47:49 +0000
Message-ID: <3edcf934-ba56-4ac3-8edb-1663f327ab3a@oracle.com>
Date: Fri, 1 Mar 2024 22:17:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate device maj:min during open
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>
 <20240301153440.GA1832434@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240301153440.GA1832434@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 9832e788-ad06-4bbe-878b-08dc3a0f53f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Cs7GdJq4dPF2WYwJ50FnyAnGegD5H0wgW7SUKzVT+XorhhMkn5Jc+9/SWw8tRrLwRRW9IyoeD07VyvMytFIqkipI32bf/5LyN5kFyqFLH7Dg2vDz0eSvucOlo2WkR1oK7kMAhBOVFppBPemDcoqeNMUPVt067HaR1JK1iihk/XBE6gqxn/aYLn7Ox9KL1+Py50DmaAdjD6cHD/npOtMPGh7TEGBtK+M9g9lgvnlv+jWsp1KxXgfc6xYepbGxvAiJ4YR4At58ifI1100Dwvqlu2JUl03cuie6XayPnw4EcgAVEdHk71iDu/ej+/bCTURxXbwMgwDmiD5RdUTA6jIrwQaiGcZdd+RWDwbP2o10Ggk5Ci6uGX9Qh78obDNwFeF8Kmtd5H4j1P7XfWF48C/RYJC43EJ5h76D8P6UHSs2Rnudd4EQLMWnLL9yfpN8GtQ1Tgp+UIk03va+xgKmcShEHJ7/DlOGy3kq4Mh9TcyJNGvDEQQJyLo6qPts4y0jv4lzl8PMZvIBFHuS2UmTbTZ97HTvaDi71jNY5KUEEwbQXRHB1IVOwPoNWnOillxlO0V7V8y+7HvHvkXMqsfC0gqWODqezuw8H7chwhxXqu27EnJLMQEq75THPttgm4Yrcpx7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NU94UzhlODY5bHdSMFo1QmJIVW1CN1RrSFRpY3ZBaWkwTUtNc1owTkZhcWhP?=
 =?utf-8?B?ZGpvRFpGcGk0eHhZRGEzN3hreEJDdDlOb0ZQNndXVWFSYlM0eEl6RERWK2Js?=
 =?utf-8?B?a0s5WjRFOWxFMVVtSmhsSDFiOEtVQi9NaVdDc3ZEbUc1dUtPZXI2N3l3UFBS?=
 =?utf-8?B?cWZocWZRMEJzVXpRbHpzcngvYUREeVhhNkdkQ0M2UkdiaXd4MEEzWE9kQm1L?=
 =?utf-8?B?YnY1LzUxSHd6bkFkT2VhOTdOSXpMSVFleGFWT1NGd2gwVUhyVzJjY0wrbDZL?=
 =?utf-8?B?d2VReFdZYVpkbHJZUDJJcEdJSk56ZFdkd1ZWcWR2ZmpTeTJyWkZwRDZmdHda?=
 =?utf-8?B?ZGE5VHg4NlZ6RnNja0JhZmFTSklaOFlzM1M0SHFVRTJRWXRmUnBadUN0cEZh?=
 =?utf-8?B?TmM2eW83ZFFzMUVKOWwveWRHaGkvSW9WSGhTdHhuRDl5MzJRMmFmRE9CUkpM?=
 =?utf-8?B?M0xaOTh2U0xEb1BqOHBScEplMXdUVXpMM0haTFJpMG5MbVhrdTNRZjA4dVRB?=
 =?utf-8?B?M3ErKzRyWEloY2hLYkFueklUWGRoQWRTNTA4TmRaUEJSQmhaM1hvYTNlOWZJ?=
 =?utf-8?B?dVdUMWFnaDlad2QxMDFKaTdVcXR4RXRSdVJ6czhXM3F3V2w1SGQvVWNmazJJ?=
 =?utf-8?B?RXNRUmwyZ1gzRXBTMUg3UTN0YXhINWx2MUpDNVdIQSt0V2hYR2lyY0pXMDMx?=
 =?utf-8?B?N1Y0NmFrUUMxaXdPb0tBMXFjSFFabWRvYnFxS3BTamord0VyNXN0TXFqb1R4?=
 =?utf-8?B?M0NPS2hGU01iVkxOY1NrMndWZXBKOUNnMFdYR0REOGhuOGxpOXZlK0xWQlJ1?=
 =?utf-8?B?WklPb2J4a0x6cm1WckplSmRTZFFYNDJlejN1clRuSzBmT1RlNFQxVkJJSDZG?=
 =?utf-8?B?ZnJOR1dkaWx6N2xKNldBL25oVWIyVG5QWHFtSWxOczRlOVpFbzB2UGtDYUFT?=
 =?utf-8?B?N3c0dHM0YTlUcjY4ZHVsQkNMOUVFS3VnK3VOdm9pZklvTW9WKzZCRjYyM29E?=
 =?utf-8?B?TnlXMUl0VlFtNnNTV2dXd0IySEl2OFpvQnh6Z3Iwd04zSFlNSFc4aVFmZlNn?=
 =?utf-8?B?YVNZMDZ0VWFrTDNsZG16MUlKaytpbUZreTJ4ZjlIRytQeVNBWU9uUjNRdng1?=
 =?utf-8?B?MjJHZEM1VmJZM1ZzMUpVcnRqTDVMS05hVGNZSkhLWm5UWVFKUnlST3JsZkky?=
 =?utf-8?B?S043MmUxaHpNd2ZJV2laWE5aTWZvSUdQRnhlSmJtbDV2SlBmZDRIbUhZOG5m?=
 =?utf-8?B?RnlIVE8zVHo5VmZBNlhkSEpSRktqbDlDRXhmbGhmbGFERGhndE1iTVI0bjRs?=
 =?utf-8?B?UERGZlpHZTdmMzFvWHNPZXFWU200aStXMW4xTmE4YWkrbFFJZFdkYlFDbVlU?=
 =?utf-8?B?R3JybzA0ZCtBMCt1Q3RuTDd1ZzVzTytlYlVMdEJDeGd1bVFzdlJJWFU0TkNJ?=
 =?utf-8?B?clFhVVQwRUV4NXowdzNBSnFFVFRVTUpzQUdVNTFSK3FlbmZjRnFxRkpLOUls?=
 =?utf-8?B?N2tIYkFuOW42UlVIaysrbThsWVNkSlpEcmtjREt0SVpSaXJNQVRER04xa2FW?=
 =?utf-8?B?SHRqdW5kUGRyTzRkR3MreXdLanhudzRRdm1JTS9Na2FMbWdHWlJndHEza0dl?=
 =?utf-8?B?NTlMa0pNUlpxUUVPYlB6OEZjTVk2eDVRK1dlT01mRUFBOGs5bFNvTk9qaGp5?=
 =?utf-8?B?dG5QcWNSUWRnZUJhTS8zQThIeWxVb2UxZHIxQVEzbWhCcnRlSGN0ZEpJLzNl?=
 =?utf-8?B?Yy96bVUzazNnbW0xTWMzclFaUXBidVEvRUdOcVd1bVdOR3ZGSTd3UDhIQ1d2?=
 =?utf-8?B?RWZXYXF5a0hNSEMxVnZTMWlxU1BWQnIrQlJrQTJ5RHFkb1R3MmJSZkNWcU9p?=
 =?utf-8?B?VjBaaTVRWnNVMXJnNkhldi9wT1gvcmU2c0dselJBODBkOFBGNzdwUDFuUXUz?=
 =?utf-8?B?RnYyaDFVR2tPYzlpVENuYnU0Qk4wOW5yRFNTWGJxamdQd1VDSHY3KzZjcUlU?=
 =?utf-8?B?MDJ4WjFQQlpBWjc3dFNMRElrSEhpeUIvdXkzNFVyUTloVUl5SW1wVGJ5RjJE?=
 =?utf-8?B?YlZ2ZlluMngzMVZFdFc5MEpuME45TXpiSWRWVC82T3ozckp0NGYwMnNkNGtL?=
 =?utf-8?B?OGNJRnBweS9PNm94V2lSNWZpbkZvR0o3OEtEQ3NZa0ZBZk9tYnQ3bmc2U0Iw?=
 =?utf-8?Q?fPjy0zAD8QRo9NBHyq4hUEbXZIQvvajmLnyeyXieNyKi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2npNdQcYjxoo3csJF6uKj4FZQBgZ6spe442vMDN12++1u647tykL0tjRfYoIgPo9Q0Fmo3qRRBFLDNJdGqyoPg8+/R8SCQ3t0tC4v+VIR5o7ZIA3jxonNXSoa8wPTL/6kYKey6C7S876f8L0PqIrNU9DtFMtx1XS8WJrc+rLJDwH+zT6cu8nUHJQosE/9CPSaxB0XHjreD3vYsu1ltfIAr59Tn/2OtojF23nZEJghHBg+wEOnwTALyaMb+HykBUbk845+/V2+inHPvNKUejNeJjK1+heNMr6bzMJhURz8ZaWa5JXMxQYmUCLfLx0HXQ42BhVlUDmw7mmSpIyoXbgNCajcFLs9JTSH+W+3qnsoQiEJpVBKYOlnwAX4qrIYXoYbjgwa/SygOjnDa1v9JxVCsYWEmiI+z/Mcf5ouqx0bpcPcYsKZ5ciZ6QKN7caPtG2GmLKZ+niEROOFSG9FRqSEaetObwMZ1FMXphzrf7bO3lXcDvH5mRghDXHTi61A4SoaO9ZUBRCLC4w5IaVIpWSbEtnbigeDAGwT+DLBt56rwfe92IPcs0YK0fgHTcgz0EuyVLKwG0DuPwwCWASOeC1bdzDFySoOk8c7cLHZlqKlB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9832e788-ad06-4bbe-878b-08dc3a0f53f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:47:49.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4q5b8ApZzuVWFJ9+yKWMEW3eBsaG7GAoL7EPhOCreTCu0zQtKySkbUheutqwsQkGCKfUzeiCqRyoscmW1W6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010139
X-Proofpoint-GUID: AGAfq-egYV3VvyPXmuVFrZzhsJzBiO0D
X-Proofpoint-ORIG-GUID: AGAfq-egYV3VvyPXmuVFrZzhsJzBiO0D



On 3/1/24 21:04, Boris Burkov wrote:
> On Fri, Mar 01, 2024 at 07:21:32AM +0530, Anand Jain wrote:
>> Boris managed to create a device capable of changing its maj:min without
>> altering its device path.
>>
>> Only multi-devices can be scanned. A device that gets scanned and remains
>> in the Btrfs kernel cache might end up with an incorrect maj:min.
>>
>> Despite the tempfsid feature patch did not introduce this bug, it could
>> lead to issues if the above multi-device is converted to a single device
>> with a stale maj:min. Subsequently, attempting to mount the same device
>> with the correct maj:min might mistake it for another device with the same
>> fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
>>
>> To address this, this patch validates the device's maj:min at the time of
>> device open and updates it if it has changed since the last scan.
> 

> I do believe this patch is correct for fixing my test case,

Right. It fixes the bug reported in the testcase only.

> but I don't
> believe that it is the proper fix for this issue.

Indeed, I anticipated that it might be confusing. As I've clarified
elsewhere, this isn't the solution for the already known multi-nodes
single-device issue. The resolution is currently being discussed.

I think I've come up with a better idea now. I'll send out the
proposal soon for discussions.

However, my first challenge is to simulate a multi-nodes
single-device environment for testing.

Thx, Anand

> This is just plugging
> one more hole in a leaky dam.

>> Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
>> Reported-by: Boris Burkov <boris@bur.io>
>> Co-developed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index deb4f191730d..4c498f088302 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -644,6 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   	struct bdev_handle *bdev_handle;
>>   	struct btrfs_super_block *disk_super;
>>   	u64 devid;
>> +	dev_t devt;
>>   	int ret;
>>   
>>   	if (device->bdev)
>> @@ -692,6 +693,24 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   	device->bdev = bdev_handle->bdev;
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>   
>> +	ret = lookup_bdev(device->name->str, &devt);
> 
> It should be fine to just use the dev_t in bdev_handle->bdev->bd_dev.
> 
>> +	if (ret) {
>> +		btrfs_err(NULL,
>> +	"failed to validate (%d:%d) maj:min for device %s %d resetting to 0",
>> +			  MAJOR(device->devt), MINOR(device->devt),
>> +			  device->name->str, ret);
>> +		device->devt = 0;
>> +	} else {
>> +		if (device->devt != devt) {
>> +			btrfs_warn(NULL,
>> +				"device %s maj:min changed from %d:%d to %d:%d",
>> +				   device->name->str, MAJOR(device->devt),
>> +				   MINOR(device->devt), MAJOR(devt),
>> +				   MINOR(devt));
>> +			device->devt = devt;
>> +		}
>> +	}
>> +
>>   	fs_devices->open_devices++;
>>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>> -- 
>> 2.38.1
>>

