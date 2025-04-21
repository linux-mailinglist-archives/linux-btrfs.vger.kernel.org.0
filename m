Return-Path: <linux-btrfs+bounces-13191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026FA94F7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A2B7A19DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20E26159D;
	Mon, 21 Apr 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEaDg70+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNrZU+xD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696A261388;
	Mon, 21 Apr 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232191; cv=fail; b=aCEzY8xzOE8HQNNNwC1/hKPsMWJlzhjQmJOva0euIoKQSydr+AwSaN6FuEc9PIAiRvIJYDWW0A+AipIx2ZXd4cN/wh9FKBzssUn5DHiOFb549iFjjDZniS647HYx7wkf0363DqD1KGsKEK4X+lnJy4eOX/Ul6hsL+EjRrcqV8tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232191; c=relaxed/simple;
	bh=gxlAp+2Q76eKAkGWEsSx0B9328hA2vapgQOM4uiKCiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paCeLVcpbZ6cYOlCyOGTutNJgPom4lkq5MHrcoGvZOk6+rN+WdSpa5ya3JS7WhZxw+skbcgvNQO8SSfGGmG97DcfGWrBNiUXRsgi44qrrYj3VopXRRkbsGpTJEyXaKUmKR2jpT478yDlElUlxaasThSGg/aN7gY8BExpS1rxm7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEaDg70+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNrZU+xD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L1D6Lx017077;
	Mon, 21 Apr 2025 10:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PDqWi7un6RIcaJulJRCjcWl1RSPjnx8RBtOIr9H1rx4=; b=
	nEaDg70+jJ/9h6SmJQzEj9FaJfRqD8ruQrcpj0ybhgE9ZyPs50VUmgfOXI0qFoZN
	ylGzLiM1yALm4IRhmUeuWSJytTnZ6kdqyIoi0uM1e4K+2hnOY5h+e+JbBVaoxcks
	R95jXVziM2zO5LCxYmqYv/jePniqoL2oYDEp3aRDevljDBtsORsb1nypH5F2+Tyl
	3qf54qTmrgmzwIBXKzIbLnV2aHvqG3L1PwOGsfliVL07/xIv9olc5ormq5pxkUI4
	1dW4Ex34ci7TviYKLurmu896EEMUjfZf7nUYO74o325L2Y/nPg0qCTKFbaKty6N+
	+K/Dr2aFj6Zz/WpBWDT+Vw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644cst7kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 10:43:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53L7uM0h033613;
	Mon, 21 Apr 2025 10:43:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464297vbks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 10:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlvMj1FRTmpXYY7AhaCvlrbyMUnFTP2K+LZNDNOkDlN0vaK/qHxzg3EyXXci8oNT/wn3O3MNnL7YtZCnd7iN6XDkilHzpt5xtr/e/qe02dwLII9joRdntZfoX286LivdJrsj9s4qz+2MLP1IR4c+rarfn5i1I0Bl61Sqqfi1MJqI02oAPg+BAYMsrJVcFYTbp41ugFNMtG1ZRr6HT/YmwweMrjy0ACXwdvn6plKaQXo9q1XyMI13KO+C4/wPfj3ljNNk56BQYmbFWBV6hJlYMm8/fVDsCcpfE0g3cKjabQr+AvdB1q876T695jU1WBlnHTWhN8J98jM4iRkzKMz17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDqWi7un6RIcaJulJRCjcWl1RSPjnx8RBtOIr9H1rx4=;
 b=eQlKeDJrumYWmii7O07o84YH0WaEWfTejb79J5HSkM6KjdMGFENk8pOVcpjebMEhyW0kImTVzPvXCXlxUU+EXBFgvfj7t+jKyxkjPkqsqr/hZaHvw8ayvCAx0uxWTTx340IS5LFMuvnWhPqRKhOCHn7NGc6H7ChXhjbLEF6mD+0DgUEnDBcT8VyOl05PdKgHKqJflr0/vkdk2ENxRaAzCKd9VGBVG5LZj00Vh6R97/SFU6emsDx/dbFZYEFdFgHeapSyuu2/ywYRpM9ygqMpEIa3p3mWJMIaS9mLV7jrjZ7W4rkFnnZVxdgpn5ammBYtLbQV1eSxrCamaoNTIe8P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDqWi7un6RIcaJulJRCjcWl1RSPjnx8RBtOIr9H1rx4=;
 b=bNrZU+xD7FdCBWb5xKsAa+TugfY6TjMpqNWl8ozzX5Z/46eg4j9KYSuZSRPjNakzDPKkSs1mXThDiZ3K5Z//2a83tpA9HF23Qv+qOuWnLaWsmpT4Zb5I8V6n1u5lo/0yBZXDjKO7Vw5wZI3Wbq3USqtC5QESgxK8Fi1i/p6CYpM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ5PPF1A1B8C819.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 10:43:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 10:43:02 +0000
Message-ID: <ac7792c8-53ab-42a7-9e6f-39cb68a76477@oracle.com>
Date: Mon, 21 Apr 2025 16:12:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/271: specify "-m raid1" to avoid false
 alerts
To: Luis Chamberlain <mcgrof@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250417102623.8638-1-wqu@suse.com>
 <aAEiwc5QxO1J_DSE@bombadil.infradead.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aAEiwc5QxO1J_DSE@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ5PPF1A1B8C819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cafa198-82e0-4d48-2f3b-08dd80c14a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi8zcWlEOXJSRWdRayt1NS9nZngzQlYxc0hDMnFZa1dSZHg2WGdSMkF6aGNq?=
 =?utf-8?B?TlprMjlnOXJlcHVnNmt1aWpMamxZRDdnMk1UdWd6eDgzMkNYZGVtSjBSVnAx?=
 =?utf-8?B?bkhrRXlVUSt3RWQ0Y0tCeGR1b0QwYnd6NUNxQnBEdXNhTHV1TDM0OHQrZ3h2?=
 =?utf-8?B?RHM0ejRvRDRQUkwwQ1cwc3QyZmlETWhiQTVvOGpDZXJodkc0azBOeFFmeWpq?=
 =?utf-8?B?d0dWUUg1cGtOWXBYeWdxZVg3VWNMN3NQS1VhVTA0V0R0Y2Z6ejhCQWRURGZ4?=
 =?utf-8?B?RWc2ZDJoUDlPcGlWL3Z0N09lMWcyQUtldU1vT2U2TytvUVRjTS9vam1VNVdn?=
 =?utf-8?B?bU55c0N4L2liU2dlWjlCTXZwZStDNktnY3VGb1JRY3dZcjMwSS9hRDgyV2Ru?=
 =?utf-8?B?UURURlByNllzeXhqSUY4THFKa21aZitiWmNYVFBUN2NhRmNzekEzN3ZpcEVD?=
 =?utf-8?B?RHF3TndzcTNwdUNYRUhYWCthTWd2L2E3aEg3b2NQUWo2THkyNlZJTlZNM21y?=
 =?utf-8?B?Y2NSd0dLaGl2OGdXa3hhTDlmUEx1S1VnYzNtczdFQ1JhTTkvQlRUZlZGYTFC?=
 =?utf-8?B?VzJVZVZsYlBKZkdrejQwWEM0U29GSmZwMVRuN1MxNWRKMi9OQXlyUENFaHB3?=
 =?utf-8?B?aGFmd1dlRDBBVVFwTUFyMk9HUEp1MzZpNndkS3BTR3lkQVJEYkhDalJHSUs0?=
 =?utf-8?B?dlo4SGJuTE1HQnowWEttTW9JeW8ydWlXM21sQUVwZGNRMHVGbmFQSXYzUmd4?=
 =?utf-8?B?elZ5b0lkelpEaDZ4N0ZXcVArTmxVUVhyYmZheWR4VVUyQUR6Z0hhaWt2Qjl6?=
 =?utf-8?B?RkVXMTlrcnpUMDZTS3VjZi9vYndRcGZibmxkUlBWSkw2Ym1SZjBKUFhsODVM?=
 =?utf-8?B?Z1l5VmJFR0hRM2JJK1RpVnppUFBmS2RBSm5yWHV0WWRkVHl1ODhndWhDU3NQ?=
 =?utf-8?B?clpZV09DbjJNb2dYcDVRMHFSK2o3QStWODlUWjl5aGc2L3AvcUZCYkppWmYr?=
 =?utf-8?B?blJlbXgwVjlwakFSR0g5dHBQeTBzU2M4WVNReExNOUdPQ2w3STZ3c3ZLdU1h?=
 =?utf-8?B?OStFWnRpcjA3UEpKV0FEL2U2dzVpNGU0Z1U0Zk9vMGxTc3pkczErc042L0NR?=
 =?utf-8?B?YzBzeVJ0TTI4RnVmRzdldDFZTk9EcEFIVFlROC9nc0d5SHZGMElOMkJZOThV?=
 =?utf-8?B?NE00YlFwSlBCK0ZVbTV1YlkrYWZ1eHUzZEFkWmJ6WVNxWlR2bndJRXNqbGpx?=
 =?utf-8?B?aFBCVTV5ZGNIZWVtODZBNjlyeFgzdWhBQ2llMGVWd1laa2RJS1c1NFM0R25t?=
 =?utf-8?B?TTIwUmsyV2I1TDc4d1JFOFpkUVBkRTl3b3ladGFQMU1WMWNKenp4cWU5QVg2?=
 =?utf-8?B?b1ZEelZ2MkpjOHhpVkxsMC9weXNHSkpnMVE3dHFVcDRMeENRRlVqMUFBZUNl?=
 =?utf-8?B?K3gvTW94N3lVREtZZkFHVEo4UTlsenRyMjJCN01QM3dVd2VhcnNWaXdyVG9G?=
 =?utf-8?B?ck52dmpOVXlBMzhaYi9ncHB6YWNkT2t6cHMwMGFVblZhK01oV1FYOW1HU0Va?=
 =?utf-8?B?Njl3eDVZQy9UVHFKMjk5bmwwL1pYMHFVdW1ialE4RGJUK1RhSTR4bHJ1bENq?=
 =?utf-8?B?amJzeXZxNjRVOCtIZmkwb2c1OStuU2MyeC9aekZvc1VMVFRQdFlxNHRRdHNz?=
 =?utf-8?B?eE1OTXdNdnhjWWpnVm5PTjNUUnVBVmlZVEtkVzZCMDB4cll0cDMwNHh2WnJM?=
 =?utf-8?B?Wi96c1I2LytyM2xodUYrclp2bGl6U1ZNOEh4bEluVFlndU1Ga094RitibjUx?=
 =?utf-8?B?SjlUV3F2eGhNQmRKQmlSeFFoeVZxWUt4MWxyVS9xTG9ZSTNYQzlQV0dWQlM0?=
 =?utf-8?B?WjlJNDRzaFlHTCs3bGRLV291RVVFVVkxRkk5SWVnZ0VOcUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFRQM0FJZU9DWERhcWRnNXU5OEphWFRaTnF4WFpNeExoSXgrcDlveFNLdWRO?=
 =?utf-8?B?VWIyVHhlUEkrSnV5M211WWRuQzNwTXFoWjJmbmRjZ0JhT0xmOGdkZG10akV0?=
 =?utf-8?B?S0hjVGxJZlZZNHo0QVpZRUpZdjZEMVR2UDNPMllFY2lpRk44RFhaVS9QbzY3?=
 =?utf-8?B?MWxjbStvaDEzelNSbTJYUDJjVWN4ZTJrRmYyWkExN01mOEVQNlNRM0JvR2Ns?=
 =?utf-8?B?Kyt6ckRsdnJ6UEVXbWJHdWhVMC9KV0tZRmNEbWF6bEQzQ2FyRDlQMDB6Zllw?=
 =?utf-8?B?VWlIdkxTUjcvSExQdjlRVVh2dnVuNGpsNHlPd1BxVTFndEhQa0dZcnB4N1ho?=
 =?utf-8?B?eFR5M0l2OFE0V093UTV1UzViM0VRYmRNajIxclJQbkFHTVFaV1dldEZqS2ZN?=
 =?utf-8?B?WTJLYVdTdEF3dFhZSGlaYmVpUjI5Z1Q4TjVFTk5COEZNK2t4WWhwV09VMlhJ?=
 =?utf-8?B?d0tCRThieXlOZmsxb3dXL0swY2tTYlVNcVFXQ2w5NkxieSt4blg4M3o1cWZ4?=
 =?utf-8?B?a0E5UkwxdUlLZ0doNUtJcERFTEM5VVVPVy9ici9qb0hlOG83RTAvbloxWFg5?=
 =?utf-8?B?L1VzdGJmTnM3cmdab0JNMWc5dHVaU3MxK0lTQmJOdFRMOVpDREc5L3FjOExG?=
 =?utf-8?B?QUhYazNpR01LcVFmODhzQkJHTjJtK0dtL1FkUFFZOW8vWmd6WUFmandaZWZm?=
 =?utf-8?B?b3JTU1B3ZFNTdnlnWm9ONHpMSFlNdDFOamc3eklLTm5HRHdOK2JUNk5BOER3?=
 =?utf-8?B?T2plbjluUFFwL1BxUVBFQzFCTFBCbFZKci95R2UySXBvU2JiKzVzZHphenhH?=
 =?utf-8?B?MnhadEdOa3V1SVlnd0YxSkdqMzZjTGNNWlpyeXJlTGZFT2RVYm9qK3BkRjhN?=
 =?utf-8?B?T0RXWnJQZG96ZWxHbHkzL1RqSTkvaTFnQ2hEZmJ2VkxyaHRRdnhaeCtZcTQx?=
 =?utf-8?B?N2V3RHRROTM5TDRDRmR3VHBPMlYxOXdHUjVQb1E5Z2oyNUZnN09GMWpVdW5x?=
 =?utf-8?B?eHM3b2xkZGxoQkJYVUJ6TytjdEtUUUpENkhMeitSSXd5U3BlaVV1cFJHb0dw?=
 =?utf-8?B?NlJLeFQwUXBFelhKYTJPWlBPdFRBSy9od1FCM0NhaWhVckVOU05SQVllOU9p?=
 =?utf-8?B?TUE1K2E1Vk9jRFk1QW5JYjZ5L1h1eUc3bnRwcmpyTDl0dk9BaVgwOTFNNFFP?=
 =?utf-8?B?Z0twdUxpckV1RE53UW9oWVdWSHZjVmRQSXNXWkQzV21idWNDMzl2SHZlTnBC?=
 =?utf-8?B?TmxVT0N0czBTSHkzZ0NwSVZQS0JjTFFtMEJiVnNCNkNvUTIvL1hSN3BGQ1RQ?=
 =?utf-8?B?OHR1TmdIRDJyRTRkanhsdWlydWRBVTQxL204VEhrZVF4YTZGYTlzV3NyTjFp?=
 =?utf-8?B?Z3dIVHVncEZMVlhhQjZLQ2lZaytWeU1jKzRCbWptbVQ2NDA1OWlCZURoUVFw?=
 =?utf-8?B?Qi9BQ3A0akhYZHRNQmdPaFp0ZmwvWVJOR2I5MFY2YXNhZDk1VmkyZVlzcjZl?=
 =?utf-8?B?eTBVbXU0eWVLV1JwdUp0eU1HKzAxZndEWjAwb2d6ZWVGMmR2cnVxK1VTTEhK?=
 =?utf-8?B?OWhhK1ZmUzJwdnIyTkJLb2pHS1l6R2QzbDBxSE52UUxUekNOYnNTTXlqSlBh?=
 =?utf-8?B?cm1yTmQza3doQjZqVUF1NWl6R2pST3M2VWJiM0dicDdGU216WXJBdGZ5dnh3?=
 =?utf-8?B?MzgzVjU2OXRHRGs4OFZqaTVsY3ZydUR3U3EvVmVnSitpMmdNeUVvWldweGtN?=
 =?utf-8?B?bDY4M3l1eHJ3Ylh3UnovdXRpVCt5TU9VN0hvWVZOSi92K0NTUDlwUWVoUVBB?=
 =?utf-8?B?dlBmbU9vZXRncVcweGpQTWlFaVc4dGpuTzJZVUVRT2M5K1AwM1AvaURqWkZv?=
 =?utf-8?B?bUowSGkveVJ1ejFBUkhOQWVpYTJkUm90M2Q5eXF0NklmV3QzQ2V5elVsb3E4?=
 =?utf-8?B?cHRjR01ieVVxK2N6aXVlcm5WZnZlZFdUQTBDMVdlL2dFTTRyNlVQMlF0OElD?=
 =?utf-8?B?TVFGU1BzanZqL083U3gxQ3BXd2xodUVLbGJKZzFsRlNjcFRKOXU5WWxMWDdZ?=
 =?utf-8?B?aWRuUW9VVWhwMWNWZzBZckZWejRyaVJ6a1ArdzNVWnFCRUt6cnZjd1FnaTBi?=
 =?utf-8?B?ZVdxQXUxcVcwd1hraWJEOHloUTAxcmY4VjZXbTd6akJPUWo2K3IxZ3dLZFhJ?=
 =?utf-8?Q?njcROVWBCL0iS3c+yDiU/AfgRUUX9LGkMFCZEjyl67LY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pUJXlq0bdOhOJvmIEnvIiKtV5ZSC27lDTo8yn1KJXLe0ABHCzt8cQ9M3HxMLGqrHTG1fz9ALkF9U3SaPHbGrMr+VeOBI2yCNmn1AxE92KQCIkqjwvs16ajPm0gQrCsP9l05PqiDvspzzRhgZqAdFZKEuJfkoH2lI33w28pnH9d3LJB4kGx/JdaYGs5iK3x4G1eHd029qcpUj/tNtAp1QvOqmAxCpew3rN7dy/Vzet3+IcxTKwSc/ddcaE/QuTbv6PFzA6sb8wi4hgwtrcw9gTm/Uyo/yqs7Ro6APQl+BQg1LifcHyPfKvh3LQ4LkZ1Na7qY+/yFz3a/iKcM5+WAX8DdsXt2ebDoRKtgUBMGSMJzZxDb1q6I8Gf1Y2b+8VocpuhHd32n7XI9MhNj6TEs/SZwtCcUKQUrGpX8ONFz47eD/+pdM34MiPAYagES6Odnb+3U7cqpTWBunCm+5+YITjo5xqmqncsJZcHl0mfmA2zE9kyVRE4mkUeTqbXVm2O7hezJWrtaV6jgYYDfhqyzfyxeCCb0jzC+cnbfVW52lpClT89H424RjeXdzp7ZVRCuQuWMqwxMNDzZDU2aH29LmRppGsQ1KHrd0WhFbjI2GMHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cafa198-82e0-4d48-2f3b-08dd80c14a7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:43:02.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iuocbKInzSY+ksKztCi2SftapOlGFq/DZSIFGmXr6w+N4sbtWtk35Ypuv+yGprbDMj99VwD+/fwdpyqhLlaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A1B8C819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504210082
X-Proofpoint-ORIG-GUID: sOBfpCJtQpQR1XDwZXnpfteKeHX0KpeU
X-Proofpoint-GUID: sOBfpCJtQpQR1XDwZXnpfteKeHX0KpeU

On 17/4/25 21:18, Luis Chamberlain wrote:
> On Thu, Apr 17, 2025 at 07:56:23PM +0930, Qu Wenruo wrote:
>> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> I would prefer: kdevops <kdevops@lists.linux.dev>
> 
> As this will just be automated and kdevops is not just me, its a
> community now. I just nudge it forward when I can.
> 
>    Luis

Got it, updated.

Thanks, Anand

