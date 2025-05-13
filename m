Return-Path: <linux-btrfs+bounces-13982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC5AB5FFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0267E3A3EA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 23:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF1215F6B;
	Tue, 13 May 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PqkOi4eC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O/0xXHVb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB314F121;
	Tue, 13 May 2025 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747180513; cv=fail; b=EvVCa8kBHuE9aJuOuiH7uuNVIfk5fEC4IZQBsacQRchvAZFZxU5rGAuIjQ6TPC0wZMkr1+3CCxEr1WMwK2X+PHW4YIWc8h7utqdAymQVduTcBRf4qEIaaEfqLg4i7zkBP0uHuoyNhYwD4uCQO53IjFS0Kcst11/YK3i4D6ngcsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747180513; c=relaxed/simple;
	bh=A2BJYAs6kQzszO03oIobxsG40g3iRYnTcoG/bTiYBs8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsadJcVU+CZugUwi2ep9grYbwFU2zEoYs0xeE4Q6BKfCfoWSbOX+bF4imksvAXu+R8EoIsU7hcXjOv8kJECnbr3f2TdriEowF4Kp7hbtMzzGfJedKucGdmg56rRZ0eCGatmxZ1jVL0DQBimOpcVuzftQmSJqtCCFEFx0d7ZMLOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PqkOi4eC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O/0xXHVb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DL0mJV008956;
	Tue, 13 May 2025 23:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=743lJzzWztwdyV5gu6la9OliXh+1pxq5TJJ3rOrU1d8=; b=
	PqkOi4eCJWs6TF079xXL3adgDfL+KRU7Tz56CQx6DrAzAIR1CvSq2/bUZpOO3EHk
	hgExLG7F60YGSWhsB5UOXKf3OfZlyJnPjhWR8NkzesOIZwS/6UV9WC3d0xz2yXkF
	kvg8zsAmRt8ETc19n8g2mL9UfRv06Y7HiL3zVAUo6ik1H6cY+gyRE2jdKLnuEXq+
	DxYyiHTe5cTmsTV6MVBNqb/Y1vsdxa8tc18VEgBU45ySU9JXk9Loz1AsAwrxpzkF
	asO8gOej+4aKSuUhLIjl6GCgcprO1D7pMHyHUJrKQtPZ55mDTeNmrscXcrrWzl7v
	0zAbMhVFZS9q79dddjVgRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchgfmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 23:55:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNjGkG016115;
	Tue, 13 May 2025 23:55:05 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc32qyeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 23:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teddneT937/HKrsmE9GM0QkHH/r/usHMSuh/hqQPc55ihXfy0lU/kuGsBNSA/mWLzhkzRIqMOxJJoQYSYfzmR865XQsge81LqZcAQaoBcqrVE7YXwvBuAoJKVEo40Nz2e6mo+dG4i+hYD3LZZgJ5CupQN0+fdNVIKZa3zNb7xA99hhnK4aBhpdx5MFe1AU2tj0HzFIIGgvAUldLBXJRZUa1HUHpKHpyJQ7USMVnI/4xbsHaJaBnK8cxa/zdxg5fNqzjMSWOElrkhulShFKqudL1x0r6RwQoIz6wsciqJ97h5kH0lwz6jUqJq8/FmbW6CkqZQiV2IoTskXa+N5hR/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=743lJzzWztwdyV5gu6la9OliXh+1pxq5TJJ3rOrU1d8=;
 b=oAaqL3In4RjEk7e2g5XD02M5dLR6dDMLM4xQDqGDjSASb7VywvJhlYQspJTmUQPjGvyj6bWkxLUWD0OnUD4HvF2YBZBbGvv0aTXh44+EQp1RsHpA4pOLGlU9+8HqujLSqlj0cSFgiKPXlnnvtYvbYskYL7S3UKKUZtvyz1DKigbiha7SaVWYSeSsdZUkyvx0UVQxgznNRaQ8z3Jw28yvyyTGP8gUbfLhb8k8eB9GQSCIKwXQNO0kc4NSDfhx3Frs+lxw9NYzT1q48aKnMkSIaf48QgCMI/rYVTjpbbSH51nHUjJKZZQr7wVhqBbPxKLgUUv1p8V94oO+mmPbo7ydyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=743lJzzWztwdyV5gu6la9OliXh+1pxq5TJJ3rOrU1d8=;
 b=O/0xXHVbFedF1VhBPYTX00NOH/VsSHWN4zowpYohla31lfLnV5tqU+yC3TkpJEx0EfFBQeBzcPDsyZ8jTGxpc7EWWo2JYD440S2JyGzlmICJxfULBZxsTddNbZ6RWyBmIGEoIkF2vEsnBuYwLYNhlKWgYAyfDlri5PK448KDUec=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 13 May
 2025 23:55:03 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 23:55:03 +0000
Message-ID: <c43e9685-19f1-4498-9996-d13d198a7d0a@oracle.com>
Date: Wed, 14 May 2025 07:54:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
 <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
 <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
 <760d5562-a9d2-4e64-9032-dd4008aeaf0e@oracle.com>
 <beee9078-8d6b-4788-9cb1-0d7ee6a6b78e@gmx.com>
 <20250513163446.GB9140@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250513163446.GB9140@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 33af6e5f-0808-4d6a-51d9-08dd92799460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjNJNG9XS0I2L1JBL1VkeEJXcmZkN2FnVHpHUkdRVmJjYnpJRURTNTJhRkEz?=
 =?utf-8?B?d2RJTGpoRk1Yb1NNckNYenFtWjFiQzQrTEZObnhxV1c0UHlLakMrTTcwdDVr?=
 =?utf-8?B?OUpIeWJTNTlIK0xGSXg1YXJqb2xuVEY0QlhVY081Rjc2WVJqbWp6a1o2RmVn?=
 =?utf-8?B?OHFKVVZaRzVrekkvVGlVakllUm83Z1FkZEJHOWg3dnNXYTZRVTNxUzZqeW81?=
 =?utf-8?B?QUJzU1NHcUdJbGJFR2xkbGMyYzVkZW5tcnZlclQvZC9YYTAybXR1NUFRMmJL?=
 =?utf-8?B?NW9pSmhGRGErUWxncmxrWmdwRTVLL0ora1dHRXZZY0FuUXIxcFY3Q2ZiTUdy?=
 =?utf-8?B?Uk1NSnFTRlBaaHBpbFU0T3lxWmd1QjJ2ZHRvWm5BRld0UmRzazYxcXByakMv?=
 =?utf-8?B?NmRYL2dLTk04ZWdidGVKTitXTWhJak1yS1lKU1dIK0dYZUF6V1JYOTVmUGFh?=
 =?utf-8?B?WEU1b2psRGlBQ0c1alFxdDJsbS9ucUl5OXpIVVVwYWk0NUVERTRQZXpyV1Rh?=
 =?utf-8?B?dk5kb1VVOXhOYmxZY29IQWJCQ1dtVkkzS0huK1ZJdHRpUXZTbGpDczVWZmpo?=
 =?utf-8?B?dXFLYWJEL3RBV3V3cFFMMnFYWGpQR0Nncmh5cjJqRlB6djYrY294cmZ6ckE0?=
 =?utf-8?B?dXN6UGV2NmZqSXdEcHJRSzdWOUp4OVg5T0N0UVV1MkxBdFVxT2Q2elBYWGo1?=
 =?utf-8?B?TXh0NVFyVHExRlpiSGlMV0hQaEJQVHo3NVd0QXBUQ2dVNG4wMXduVWFSL0Uy?=
 =?utf-8?B?UHJ3SlQ1R3U2eU01eGU1V3ZJSXYyMnp1b2Z6SFA3OU5qWDR1MTJ3cUw4dWxq?=
 =?utf-8?B?a2dZM3pGNlhuZnBpTFVVUzNVM3EwckI5Y1FmWmNpNHFTRlA4Ry9IVjRaSFUw?=
 =?utf-8?B?bTh5Q1BHUVcvY294SmpOK2tJUlBKMEt6Uk5QT2NuUk96Yi9FL3liRStDVEND?=
 =?utf-8?B?V3BmOGlSdjczVFRDVGFjM08ycGVDZlY3dVdlZFRSSlhBam9oZEtnTDJydVVr?=
 =?utf-8?B?TjB2cDRoNlRtQm9sdks0Y1gzeW1WRVV3a1lORjkxV0pYbWRuc29TRVBVZWVm?=
 =?utf-8?B?a3V4Ynhhc3ZTajlkSFB3S0k5VXI4RkJmNjVtR3M5djAxWEdOUmZwNnhYcktx?=
 =?utf-8?B?K2ZsYzhseUdza2szN2FmZjlKeXBRaVV0VDF5akFlVVFqTlh4OXRKZ1FBU2dp?=
 =?utf-8?B?dFdzSWRqNXpiMHpxNmg1UEVRWXQ3b0xlZmM1RDNPT2VYYm5SQThpN05Jakhp?=
 =?utf-8?B?Vnp0YnV2N2F3bEtSOHAyZGxqTGlVYitSenhrbVIzU2prT3AwMmpCc1dSbW0r?=
 =?utf-8?B?M1BDcThONVJlNVBybDllaHZPSjRTTURWQnFFdVRyQWE4OW10Q3BNL251WXRT?=
 =?utf-8?B?eXNFR1NZenFrVjJBNUZCdHRMRnFWc2QyQTYvZVBXaXIyUDd3eDlVdEdJZnVL?=
 =?utf-8?B?cHkvdUdCa0FkZmV2ajZqeDRSRG1WanhrQVR5NWZFZGg2bWFhdm4zVTNBVnhR?=
 =?utf-8?B?MkhFZGJycUM4ZVFNRlhmWS8wakdiSUF3RG90Zk52KzJZSnp3NU0yRXYrQlYy?=
 =?utf-8?B?Q1NYY0ZjMjFzZzR3RkdPWDZqSXJPNlV6bnBybFdoZFlDVWFjMWdkK2U3TEVF?=
 =?utf-8?B?Y3lodUhPRjhtaGhDZzEwKzNGTDgxTXNzY2hQQVlxWXg0Y2h6cjNmMlBPNlQz?=
 =?utf-8?B?dXRqeldyTnFFcGhtUDhxbUtTVW9UWjhsRUZHc1dRWUpyYjFzZVRhdTU1c0ZF?=
 =?utf-8?B?dklpRDBReEQrNmZQOEdyL1o2Sm1ocWsxZXNHdDl4b0Nrck5WQ3ZJd0YvLzds?=
 =?utf-8?B?cWNseXpYTHJtaGY2K2ZsVmM4Q0djTmVMYTYvM0tDZjJrNTZIS2RZWUhCNHJV?=
 =?utf-8?B?R2hIVDNScjRKc0lXS01FQ3M4MHZnaWFnUjFFRUNzcXUvUXhrY3lvT05pdkRU?=
 =?utf-8?Q?QDKI9CMvVWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhpRnRiQ1pObWRkbmdYNTYwZWs0M2luK3JVNERMYllSdzV2WWFGZ2ZhMEFr?=
 =?utf-8?B?OEFvejVEQWZaUDA1QzF2a0V4cDJNSzhuRlQ3Y0xBR0hyNW1pWTRlTzF3ZUVJ?=
 =?utf-8?B?M1ZuZXVWNmtoeUk3MTdVQ0s2U09ROFJ6WkJPQmtFT0hJV1MrdnMwdXVMOS9H?=
 =?utf-8?B?SWUwSC9UMUFjSTliWW1JT3lHaWVrWUNkWlh3RTZCenJYQlU2Vkh2OFJvMEor?=
 =?utf-8?B?WEE1Zm9oQW5VMWdzZUxhekVicEhNS25oUHJjdGxMUi9HdWFha3dzaTlKei9L?=
 =?utf-8?B?TEp0OHRqd0NFTU1ld09MMWtCMURrMFIzc3d4V25rWUVObTUxdkFnbVZ2V2ps?=
 =?utf-8?B?dnVUUVNFNHlpbDQyNkErKzZ5Q01PMkhlTTJRWC9RSC9uekp4MUlmN1NKaGZk?=
 =?utf-8?B?N3RQbXM1UWlsdGd0QWM4NW1GZmpRa1paRzJ0NTNsdjZUbEtPOVNmRWc4UENz?=
 =?utf-8?B?SWZVK3c1N1E3OEd6K2twUThKMlZNNkx2V2Ixbjl5Nk5iN25OOEFNVXd5L1dz?=
 =?utf-8?B?bE5RVFYyeXV6Y0h0RXFsbXcrRTljbXhuczVSU3h1TC9xMjgzM1lDcVpzVG5D?=
 =?utf-8?B?Syt5N0YzK0JMNy9sVHNLR2JPVUF6WWxHMDFFWVM4VUEyKzVPUDNxUk10VTQ5?=
 =?utf-8?B?UWN4eUdsdW5VTFhHK3JJaUp6OVNtUks3bGNuaXpoK0VzYzkvNCtWbGVRdERI?=
 =?utf-8?B?akZTTFRDTE1JVFE2ejFOWEJuZnFTZnN3amgwaXdIckcxRmJDY1l6akpQUVh3?=
 =?utf-8?B?YldVekpnNFdlSStVNlRFQmVzRkFnaFJwYmxOWnZKMU1BVkJZZjlLODNIeUJ0?=
 =?utf-8?B?SGE1bmFQZkZUb2NlazVESlk4bitKME5NNlVLMkFkWFNDb3V4K2MxV29yZDZn?=
 =?utf-8?B?NUdZM0lKYUNPWXJpTGEwZmlTdWVkUHRSYzN2Sm1kU0xZYkMvamVtbnU4YnJu?=
 =?utf-8?B?NURXNXR6ZmxYOGEzamwwck9ESHdqSEhWTWQ2U1g5T0VaQTlmSEtRdytQMWpu?=
 =?utf-8?B?TC9UWWdlbjIrR1pHOHNaM2Z3c1U4TmQ2clA5MnVBeld5K3VCZTR4VXJBbFZu?=
 =?utf-8?B?andrTTIrVWpvbTlmS2FRcVo4YU9CeGZkVmtBLzJEZFgxUE56d1FIL0hsZHFi?=
 =?utf-8?B?MW5sNXk1UFNsZkRVd0NwUzBCcE9WdXVVNERBcnM5MGlMWDB5MVJIWnlFRy9V?=
 =?utf-8?B?TDhld0NFS0tpai9icmhXTktIeWRyQ1VSMElTMDdlVmcxczFpdDRlVm9GY2c5?=
 =?utf-8?B?TktJeUdBcVZud085ZXpJNEF1YUJUWEVhRUlCUG5DV2xFbDVIbDRPMEpLQ1Zn?=
 =?utf-8?B?MjZsbFFaTzVTN2FDcTFOZ1hIdW1xMVBnbVN1TkNKcGZtdVF0RDMzWUFZZnNP?=
 =?utf-8?B?cUVUeEdZZFI3ZHlNbUxyNU1QMzFOR0tqMUxRK0E0S3BFczRCQTljdFVnaERx?=
 =?utf-8?B?V2FjQWFaTnl1eDUxeXhvMlhpMHZPY25CQmFDZjFDTXZlRk1BQU11VkJaU2Ji?=
 =?utf-8?B?Q1V2S2hRWTdIZ2huVXhPaHBuYWtjZzdYTFAraExIUUFmY3lOcVU1ZzhJYXhJ?=
 =?utf-8?B?eXR1RTNGRFVzNWJKbWcwS3ZTZGVNUGcrekZLT3Q2WlVXT3Nmbnk3NVR1Vmo4?=
 =?utf-8?B?U2hhaFVJb0kxQjlPWHl6ZHZRZTRJdEpNUCtLUEVaRW1Md1pUZlhKQUxrdFV4?=
 =?utf-8?B?NWNWdEREZEtjNXlDczIrS0Y2aUZlTmtMMTczK2tnSWNzSXFjUjcxRVUrajJ4?=
 =?utf-8?B?c3VXeDNUYTA3Zk9HTUZsMDNaeG1vTlU2bk5lNFZ1c3ZZWXUycEtxNUcyNy9h?=
 =?utf-8?B?cU9EWE8rOEFmU2wyYSt4QmJwcGdhSWozWU5LMStGM2l0TnJoMHRybFZUeCtL?=
 =?utf-8?B?WlB4U3lEaERBQ0FCMHlhMDB3c1VDeDJCZC8wcVpHdVR4NHdMYWIwOUhHYnkr?=
 =?utf-8?B?VERWUi85LzhuS3RsdjE2UVpLWDEveGcxRzhXb01BSTNTNjBnYWwxYmRGTnhD?=
 =?utf-8?B?b3NKOThaRGp1NWlENWtnS2phZW1oVFVrS2ZkNlBGU2VoWGZXZ0M2NkY5R29S?=
 =?utf-8?B?Z2cxY2o4S2phb3BRb3BzRDJuc2dvSzhtUGVlTzlMd05nTDRhTFpkbUdMTFM0?=
 =?utf-8?Q?vsM2GmJ9pCOCIvV/Sy1enwFAH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sFrJ1J8dMFv/ikcNdDcYhjmDZ8mEQENzjYPdegQhJKgF0NRwM30HBLYbq4/4tBKF/PiyS650IQr2sw0ZuPi29kH7FpQ17t2pGIczKq2bhXgPCbqfDnra0QATXtwDmOhDhYrEX5kgKwNHr7uxEOhUyDhnlXzcE/7DcqnK6MUWguKaDppR0NqJ7JsIjQUEF8cE2SsYC6ls5AoCPIJTZ1OI2GxgFdffN7rrsxIvi9kH3v/QqhN8Qgl0bh5aLsFis/0NeI2BY8WcYQlZTS+mkva8nx1BCiPczKyOdBegTrYvPdwSXDQfizicTCSRkJV+l7s2ow55DvD4BvBRjY/KOSmLSfuGWBLsxCAut2tJUxsW4mNOZZmlrvf22Jy9ZXo1tBKYoq7KqvsPUSBd/VU+ZtpAkeu5qkSDV81Y+CNfonBrhddPhkgDy1XtaNUNixWjGR4xUIB5lmSTiUNI+NpsGpZvKwji/CpDmCm1s5t9mxjktPcldVW/rPWaoUxhG5O16lw3RN8x9qjRrE67BF7OaSfYSbUa1mLoDyjc6HG/i2QZInz83Ux9kNlgXMEnyQ05WqaSK0LzCiTC0/lE4uQ9SckXaaL38wMqjsBl1FGBvEexVrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33af6e5f-0808-4d6a-51d9-08dd92799460
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 23:55:03.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pY1h8iKkKnmTfeREQq2uhfrMKSKPzYttmotmvdtVozFqhG7YvAIFdO6UX4bvsZ5DnbURF2oFa0fN6efFCaoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130225
X-Proofpoint-GUID: o_0BnHYIndakEf3SJzvTOy9P6JqFy-Sg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDIyNSBTYWx0ZWRfXzhYejhISaJ2Q VQxgLFVGkvZGFv6TUaEh5xGge7t7WXuE+vMcgM5c3Y5+aB821kLuM9ZB3/V1kP1eUGVjcBnxyCi vK8B8nt5D+5QFSwlE1dkhmzGyQPTbhn+pCPkIy6HqRQXDEZYImgfH8ItIvzQeGgMcIAv6mmVIZc
 EgWDgQhWpBSr5nm2XrnLlOsywFV9Znahpn/iDz0wyr1i5SbDDat9dIUN7XK1Ek9N9ENiRI8ar0O vKsUmF8qQcmi0nWe6ga7rj1/K13ZMK1oypE1ZSVu/RSj/O4QjKo2PZZ6TgeYrWRHCdrA5Tp7CDO WBeG1/ESaNzEjwQWQEC4BX8LMhuH4bCQWnhih18M8d0logqMF9PRyC1AnTjtsXy5GVFUX23aWl3
 TPEtR41yGieDmV8wBderGBoXJIBJHpNoovxWGTOk7xoQeS1tho3vzRX2X4zBZyIr3f61XeGA
X-Proofpoint-ORIG-GUID: o_0BnHYIndakEf3SJzvTOy9P6JqFy-Sg
X-Authority-Analysis: v=2.4 cv=Da8XqutW c=1 sm=1 tr=0 ts=6823dbda b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=EKodqQyD0hplZ_EzdVwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 14/5/25 00:34, David Sterba wrote:
> On Tue, May 13, 2025 at 08:23:54PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/5/13 19:46, Anand Jain 写道:
>>> On 13/5/25 16:56, Qu Wenruo wrote:
>> [...]
>>>> I'd say, if some option is deprecated, we should not use it at all.
>>>>
>>>
>>> It's marked as deprecated, but the code still needs testing.
>>> Also, since fstests runs on stable LTS kernels too, it's better
>>> not to remove it yet.
>>
>> For older kernels without "rescue=" alias, it will not cause any problem
>> at all, because it will set "enable_rescue_nologreplay" to false and
>> completely skip anything related to "rescue=nologreplay"
>>
>> But different vice-verse, as "rescue=nologreplay" still touches the
>> older one.
>> I do not think we will keep the "nologreplay" support in the future very
>> soon.
>>
>> In the past we had some problem relateds to "norecovery" mount option,
>> deprecated it and reverted back (some other projects still relies on
>> this mount option, and all other fses have exactly the same named one).
>>
>> But "nologreplay" is btrfs specific, we can remove it any time in the
>> future.
>>
>> I think this is the perfect time to considering removing "nologreplay"
>> completely.
> 
> Standalone 'nologreplay' yes. The warning has been there since
> 74ef00185eb86425215 5.9 from 2020, which is 5.10 stable. This should be
> enough time.

Got it. Thanks Anand

