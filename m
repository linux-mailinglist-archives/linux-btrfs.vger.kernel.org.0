Return-Path: <linux-btrfs+bounces-11321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99692A2A930
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C4B167885
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89922E403;
	Thu,  6 Feb 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0N85N1G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tJ9gFdXK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CD13D897;
	Thu,  6 Feb 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847531; cv=fail; b=FaJ0t4EFvNxsNZ3ixk5aEVqGVwmYH5MdWeB7EGIM5c54Uz2F9k2yJ9qXTqo09rX1wC91E1BxAvNy5hLydpD6Qmwwb9/Yr2qSuySJ2FBtEH/m/bTtm5DaQHnoOCsAlm0fOSnL9XE6b6HDKklwUzv2zwjbHkF/T8Y0y9PqPCuQlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847531; c=relaxed/simple;
	bh=dwulaPdYW1G5Hy2O9YrcG4lOOUqtF69nyuZJbTn+gws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CnN46Pfueay/uPJ/N6wi2Nd6iznCI/WNiktlNeLSFDQm/IcwMBrCWf7XDyTUVsdzs0BrDmpmb/+cNEQkzDSfnq77ygWN+BkETTbYvfw6eFY+DBcFCXrXIPqBwUmq/6yTtKpxc+WJ8xxVFK5+WG4yKmVjX2Y2unYA2ZRXtO350bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n0N85N1G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tJ9gFdXK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161fuAj007535;
	Thu, 6 Feb 2025 13:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/6LFA/L73Qqk3iUWe+PStH84zRCtdAx87TeAVuvDBpo=; b=
	n0N85N1G3Nq4t8QzyxfjbzgvZFZSQigSxfW+V6U702rq3K74hTE0Znf8YOZaR3zW
	KmJ4+AVe9n/1X2NqHe+t8X28mlLWKs4sR2uUBh50J31QbSY0+GTLInM2tX1RpNt2
	dRqXHqhdu17M7jOp5OTjumsFtbyLK7U4fv5108pf3GRl13ct0wzbPjHwKEGDTwz/
	eUWk84Jjl3VEluA56Vq14R+QRQ5jyxqZ5w+2Zc5pkJlsK8AI1G+y34qtWJlFJeqv
	wgD5RwBTsV0Nel0iRfQPF9KpUQzB3dugPyaPJgn7S72rkYc/NSQmJSn+mcf0kxTM
	E8mBINnBCXwINJc1tJ6IgQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50uajgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:12:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516BoCuv027033;
	Thu, 6 Feb 2025 13:12:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fpy2br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfpRVfpwKAk4Gg2gVLquWrvb29t8owWxMaSniYBNxfN1GkvBL9UMSD/Lmx2TxaH9zlLIZYL7F46LSI9S/ltLSXHLQOR0Cmvr5poOADZATKMxvIyf1584p525h5527r7kQ8ZNBOyqEH42p+aYNU1N9XXYyxtj5hnavacz1BNyIOcOSn91RXLqEsor32hZBKEMncPuDJR/WVQg54DkzOFb0ffVG7q+9/og6Z+uo5BH49/x8iIRNseg1stVlcBaSFgXrbrJraTtUKTxuuTY2Ryc19pZZyCBtC9ZQ+/98OzV/zG6b0C11Zue+UX/2rz7YTEZDAWn5zAIsw61B0Cvr/enuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6LFA/L73Qqk3iUWe+PStH84zRCtdAx87TeAVuvDBpo=;
 b=rhj93dWd65sYaTwKYqlKNRU5sku3z3R70w+tuh4J1afrH7Wj0F7pyvBjjdqvjFBPv+zhO4rQW0kRS9ums9YCGxfpaxvGjXxC8C9qLMg5c8Dkg7eoRSSmfdf64hbPXiVMRZeT4GeXQUf27/hOkf6OMNLZBdT7z5EUMrlx0JaA1RP083SUOcejhYYzxLOhjOegWI9+S89qcL1HZheA9mE/sJUJs5UPeplB2qeTFT8nC4rlqqIznVPMI3HjS4mavakEzyJVsy8UCxGA/KQoLcmx95irPYHs83NUjQ4V++RafXk/OuSI89FnlUAKVt4GGhbryqaRGEefPvMC2i9dbN8+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6LFA/L73Qqk3iUWe+PStH84zRCtdAx87TeAVuvDBpo=;
 b=tJ9gFdXKO3I03VQREppvMWxrNdpP2lCj0/TxE2GzVNwt7yiIPrETMdSzkIXYjW8+7Ky00XBytLGF5Xt0YcgatF3uqrJezVqhYL+0H3g2hwS2H/v//dORID87ap4PSqC5HLlT0vscmFxEZikrJZhbMZtb/teQnWgyrqHqtsAcCkE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7354.namprd10.prod.outlook.com (2603:10b6:610:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Thu, 6 Feb
 2025 13:12:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:12:00 +0000
Message-ID: <68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com>
Date: Thu, 6 Feb 2025 21:11:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/226: use nodatasum mount option to prevent
 false alerts
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
 <CAL3q7H74oD=fL9rRJVdQhONhyApOFDUFt=tcES_0=DcsQbiVGQ@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H74oD=fL9rRJVdQhONhyApOFDUFt=tcES_0=DcsQbiVGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9806ab04-ffff-4826-ead7-08dd46afd75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25rMDZiWk9EU1FEV0RBQXVWWko5QWw4ZVNFbkVmOU1uZURsTlNQb09wT2hF?=
 =?utf-8?B?dUp6L1Y4SUp2bmRURXNqdExQR1EzdENwZ3UycHlvT09RdDYvcTk0R2IyRkpx?=
 =?utf-8?B?cCtHdVRiNW9GdDh1UnJXQk9JZU50Y0tZYjBLVTVXYXFUdWdWM0dnQVoxWUFy?=
 =?utf-8?B?TWV2ME1jdytrYXE3Z0djby9nZnFCTE9TN29pdXVRMitIV0IvQ01sWFBnSEtj?=
 =?utf-8?B?TEdwM0lNQjhPcjRJWG1BRDdSbEFaWlp6NlRsRGVIUlhDUHRBUFdkRkFncXhH?=
 =?utf-8?B?bDJWWjBTcUpCQTcwaGFVd2pBNU44b2RRUGl5R2xmbXpnOFlySkFuZFdMNGoz?=
 =?utf-8?B?czBCSFAzVmRhR2VJbHlQeDhUVlE0ZTgxNGRFLzF6ODUrTVFLRUFZNzNaa2Ry?=
 =?utf-8?B?enJGYkhOejRmaW1Dbytnd0tUbStqTFZrbWx5SUpaZTNzL2t2cDllQmVTQnl1?=
 =?utf-8?B?b3VVOUZ4c3pZY2dFaE9HK3V3cVhMd0NMOU5NZk5rdFV6bUdHWklNL0xNRkta?=
 =?utf-8?B?ZGVPeHpMT04rNVhwQUJKc1VkRnlFSGV2aE5PME9NUG9tU0d0UmRVNlNqMlhB?=
 =?utf-8?B?b00rSlZ1OG1YVHpET25TMFgvYWs4dmRTMnJBRG4zTk9DN002RHd6aXhHd2Z4?=
 =?utf-8?B?aTdSS0RvODczQkpkbHJXZGlGb2RZUkJrTTRzWEFmSWxKQkdCc0JVWG5Lb0U4?=
 =?utf-8?B?TE1BYXJrY0ZjSXYwRThzL1BBemtnWXMyWk5FcU8zMlBhcWF0aFlpbEFwbGdT?=
 =?utf-8?B?RHNUcVJrWmpvRmhmSy9VYTdZN3JnUnppVkpkRis4bHdpVjhWNktrd25wd0p5?=
 =?utf-8?B?WnVITjArYnpiYVVBMFBXVDhrakpaK08vSDBGVTJ2WXZGZXpiSGF0Nm9EY1lS?=
 =?utf-8?B?aG1lQkI4M0tpL21HNHRvL0lqUmgwbWV2RnV2dTBGaWN0Vy9BNWthZ1VTQ3gw?=
 =?utf-8?B?bW0rR25ob01OUVFWYUxBTUtBUE9WbUUvbkp3L2lLanNSdEpUS3h0eVMxWnR2?=
 =?utf-8?B?cFJqbUdaKzZ5OFBhUXlWT1cwbkhMVkIwREk0aVcvR3dzaW0zWXJsNjY3NzJ4?=
 =?utf-8?B?T0NadWcwVmFIYlh1L01vZTZwbFRXMzA3bWkxK2JuMFFwNmV1d3o2V2Uvc0g4?=
 =?utf-8?B?RXVHbGE1L3VlVjdQUkdQd0hFNkNEZVF4QWxNR2FUOUtXMWZ0YzB3eENmamZT?=
 =?utf-8?B?OGxQNVB2U3NiSlp4UWladGx5U2VuUU03b1F5RzNNYk1SOUw1SmVRdjR1UWhN?=
 =?utf-8?B?Q3FoeFVqWTZZN2l5WUxySXFTVVlwcnhZeHVWdnJENzhRd0ZVN1dqSWtvd1NP?=
 =?utf-8?B?aG91Y25MWi82b2JidTVydURWN1JlaDlzVDRrSEd3eEtmemoxZ2w2dUhtL0dX?=
 =?utf-8?B?dG9vRzdvaWpNa3EyaUw4ZWxBa3hrNDdzbWxvRXJiNmlYQ2psSjNIZ3kyUlRW?=
 =?utf-8?B?STNKbHplaDIvaDM3R1hZdHlqM01mQlh2RjVwYUkzTUtVTFFjL1NCVjNCcUJw?=
 =?utf-8?B?N1R6YmJrVmtST3BjZ3ZZN3kySWRPeW1YNFBQcGdHRkNid1BNcDhuSGZIa1Nl?=
 =?utf-8?B?NWhiaXdTTFpnS0ZlN2lEWHpxTkNKWnRKMUFzaStiVDRKUTg0Q1NlcEZUbGo3?=
 =?utf-8?B?V09tTmlSVUVaMEJBY2JjalRlaExmeExaU0dVOU9vZWE1MXoydlloRlltSG10?=
 =?utf-8?B?K2VsWEExWHU0K0tWdVg5bW40L01jSlJUVXR0d2ZzMnlST2dqMzIxWWVtZEZ6?=
 =?utf-8?B?MU4wTWVNVkdBeU1iU1hVSUxMR2VNVmg0MlhKVG8vcFJKVVk4NUNnREE3aVNV?=
 =?utf-8?B?emV0N2RWQzl4enFGM2pyeU85VGU2My80bU1mbmora3FoN1FpZkxVNk5NQzRY?=
 =?utf-8?Q?+Ew1H47TsG+Ci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJzcHE2azFsVU8vOEF2U0M0VCtIZTRGSmQ3dFQzQndiOG9WeHZmVG4xKzN6?=
 =?utf-8?B?eElMUTdmaFM0QXNjMHUzZWZ0NG02RTNIVUlPOFNtVUZvZmFyS2d5U09xMjdN?=
 =?utf-8?B?VkUxL04rNEY2dlQxTWlxckY2c1U3NWdhZ21uVDlyVmg3djVDRnJqYy9uWGNy?=
 =?utf-8?B?TlNZREFwRldwN3FrRDZMU3ZWVERqNkxKMGNqQWU2WHpHZmFycVVnd1Z1VWxC?=
 =?utf-8?B?TXhiY2djdnlaUHJwNGFPZlJPeHovdFN5Qkd5MVY3RE54d0FGcVZ4MFlVME0w?=
 =?utf-8?B?dmtMa0NGTzU3ZFBFOUdvS0VBTTJsd0ZqWHgrb3RpWk1KQ1dXUk9Tc29iNlJ2?=
 =?utf-8?B?VnBpcExPRWE0UlFIOVVIQU1reVNoaFJqampvVVY1RDAyK1pySWc0NFg1WVps?=
 =?utf-8?B?YjJzSSttSVFQY0ZZUzh4NHVkL29pYjZrTFROcU42Z2lDTWtJYk93TTFUa2RL?=
 =?utf-8?B?T3AxdE9YTytHRE1ZeDJNdDZ3UVN3M25rYkNEOVVnRUFoQjBiMjhJYm1JakV2?=
 =?utf-8?B?NW4wMDYxSlJ4SVpBZEE5Sk9KRzdod1F4VTE0WHo0Y0IzNVJHUFpvc3VlTWQ0?=
 =?utf-8?B?WEFWU204bWtWSEZiRWhkVGxJdDZ6TGV3Z0xzQVN1Q3ltd1BNS1gvVWhHUlps?=
 =?utf-8?B?REZqYkNCdkJ4UnZiTWdBa3oxdllEYVI4MEFnTjE3bDdzK2loc3gwUjdObXBr?=
 =?utf-8?B?TGRieFlZYWRrd1RSKzdBZnZnTFZKTGZZVjg4OHd3TFZINThMYW42YU9iNG1v?=
 =?utf-8?B?Qzg5MU1nTWJUS2M2a095Q0NjL2Q1YU5wS241Zk54dGIyTmFvTGI1bVZUZTdz?=
 =?utf-8?B?WTZzcUp5VE9zRmpaY29CWkkzOFhmTVkwRDN5OG93OHlYL0NGT3dnZU5nMU1I?=
 =?utf-8?B?Z1pDNXFGVFFLK2JNcVI2ZEg0YWJRSUtMUWxLdDNENkY5WTlCWW0wUC9sK0c2?=
 =?utf-8?B?ZVVRK0x3L09HYXNubGJmVWJOYTVqWXJIcThNWEpXbnZMMG9ITVBxWmJoVkxI?=
 =?utf-8?B?UEp5NmFUSDZtNGtQcFFPWk5nNnFPbWp1Rklzd1hyUUprbGRDWjFDdWlXVWlN?=
 =?utf-8?B?RnBxNk5BTnd1NC9LY1JqbXBXQ01rVDIxUTB5SGRSZUVCbUU0QUwvTERod3F4?=
 =?utf-8?B?NThLN1YxQmwwTjZKZGZ6Vlk1dmQvSGlEMG43V1ZBczNCVkdaWnFROERxUmF4?=
 =?utf-8?B?dlcrQU43RGJMT3g2aG9nVnlycng4REx5RWdkT3Z6d3dIL2pSV01jREx1Q1VT?=
 =?utf-8?B?c3FXcXhaZ3pJVDJISjZId2RaSkloWk5kWUgvSm9WRU5IbDBUVHUrSXlSeVdw?=
 =?utf-8?B?MWI5Q2dwUXV3b25jeVdnWUNMRnNSNW9LWVpVMG56SGI1aURUc3RIVTVwYU5J?=
 =?utf-8?B?K2orRWZ5Z3c3UnFCd0YrMWptTGpkcmhsOFRGazZzNFg3ZGNTcGdhT0U5cGcx?=
 =?utf-8?B?R2FONy9QM3dsbXZhRUFyVmVwUXBFSitzTVBuZmFVa0phV3dxeXZ6TzRjanJy?=
 =?utf-8?B?YUJaUW4yRUxRWW9JWXFRanZRTi9kWDNONmkydW01OGZvS0s0VlBWTDZHeDd6?=
 =?utf-8?B?NWZjQWxVRnRORnhaN3pXaDJaVElDUUUrbTJUazV3TkUzSkFneEN6elZUakhi?=
 =?utf-8?B?SitnTkJNaU8va3laRDY4RFM4VnFhNWQ5VmxJVXAzVmZSSExnMVFKdmJKcDBk?=
 =?utf-8?B?SUtsdWxaM0lzMXB3UnRiL3VZZFpDU01ZRHAxNzNCRHdaN3BUWFVucURYdFhQ?=
 =?utf-8?B?WUx2alBuanJaeGZMbmcrb1VmYzlYY2VNTDBOWlRibzhjTm1nNk8waC8vSzkx?=
 =?utf-8?B?Tk04RDBaSFMyWFByY3ZNTExGMERGOGVmL2FtSWFVRlZDWUFUZm81S1kvbnpL?=
 =?utf-8?B?ZGppc0ZQdGQyRDlxV0ZPbERsc2NzUDhzWVhJdmY0QUtkbEowZGlwNmMza2lO?=
 =?utf-8?B?b1Z1NklBeGtwcGFMMzRsNFN3S2xoQ0NBMWR5L3RESHR5bEE0eWg3M0Vkc2Nz?=
 =?utf-8?B?ajQvYUxOaGZ0M21ZOW0zdi90aHR3a2RPT0xyckNnRU1WOGc3ZGZkcC9ZdzE1?=
 =?utf-8?B?WUNVZG9zbkd4YjBGWnE3SkxOTVV1LzFxaHJBWlc5Q0d4TTBOWGlmS2xjMWpX?=
 =?utf-8?Q?AxF+UjWSrSBetyHDrl1wUWmMi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wWA7Wv9qQTc389Yk9Pi0/81X1tZWC3OhxNWc3QYQZZwcfzJu4D4jD426N6tB3mCqsws3Szbc6vGs3S+vZd7JxtNt36MCmYRKNvjD5rk6boRSAnNg5ngoAAQ4Jj1w8ENExA2G41eWSD1+s1mElV1z4lH3iUw+YcFD27hiuoQaiBWGtyUMa7ZQp+SLCQf0qVeEibn505BTLx3gIuK/Uv/9OfRqf7pzQn6GN45A83ha+BeXvOMpZh6zCfw8faw2qw4JQLgiixpCjER9dZMTEP0v3bB4hZopAAgPj2StzH1CpwYkOn+RUdLRw0/5YkhrV3tXyWLuCzHktg347yTUcHTmO13XfHaM5AbsTr3QlMwTZYQ3ZWISoYMIeon3fykONEcadCcdQM/+qPnnjIMKyI1bryakjql99HEdzgn8X8kye8m4IjmTvkKupZz1CvkdmW/15JExHofkU4lfllrfz0ZvzRAp4dXRrICOo2Y+xb9h1yEaMfxdbk1JYdFZTGC3nGrzUUl2ckiXHTqSrej+RYXCS0dtpdCxBtamUT60ZhVBIPxfsRMG0pXsKvycVwei3foZMvvjVRe0+gvLpVj6zaZ5TN3TgJNuQguV5ZLCuD4jIEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9806ab04-ffff-4826-ead7-08dd46afd75c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:12:00.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mceo+rStKVHxEpmypKNNfI5lwS4XHJnn0+SJFotDIKJF+hFaBgTjMY6z+EODZRSzxOY9i+oRElTqpb6uD55fDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060108
X-Proofpoint-GUID: 32BkSZdvY4XNeBGvl0Bv2vA_X3jy8brO
X-Proofpoint-ORIG-GUID: 32BkSZdvY4XNeBGvl0Bv2vA_X3jy8brO

On 6/2/25 20:10, Filipe Manana wrote:
> On Wed, Feb 5, 2025 at 9:59 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> With recent kernel patch "btrfs: always fallback to buffered write if the
>> inode requires checksum", the test case btrfs/226 will fail with the
>> following error:
>>
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 btrfs-vm 6.13.0-rc6-custom+ #209 SMP PREEMPT_DYNAMIC Fri Jan 24 17:23:03 ACDT 2025
>> MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>> btrfs/226 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/226.out.bad)
>>      --- tests/btrfs/226.out     2024-04-12 14:04:03.080000035 +0930
>>      +++ /home/adam/xfstests/results//btrfs/226.out.bad  2025-02-06 08:23:42.564298585 +1030
>>      @@ -39,14 +39,11 @@
>>       Testing write against prealloc extent at eof
>>       wrote 65536/65536 bytes at offset 0
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      -wrote 65536/65536 bytes at offset 65536
>>      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      +pwrite: Resource temporarily unavailable
>>       File after write:
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/226.out /home/adam/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
>> Ran: btrfs/226
>> Failures: btrfs/226
>> Failed 1 of 1 tests
>>
>> [CAUSE]
>> That kernel patch makes btrfs to always fallback to buffered IO if the
>> target inode requires data checksum.
>>
>> This is to avoid more deadly problems of mismatched data checksum.
>>
>> But this also means, for inodes with data checksum, RWF_NOWAIT will
>> always fail, because we will wait writing back the page cache, thus
>> breaking the RWF_NOWAIT requirement.
>>
>> [FIX]
>> Update the test case to utilize nodatasum mount option, so that the
>> direct-IO will not fallback to buffered ones unconditionally.
>>
>> Reported-by: Filipe Manana <fdmanana@kernel.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/226 | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>> index 70275d0aa2d8..359813c4f394 100755
>> --- a/tests/btrfs/226
>> +++ b/tests/btrfs/226
>> @@ -21,7 +21,12 @@ _require_xfs_io_command falloc -k
>>   _require_xfs_io_command fpunch
>>
>>   _scratch_mkfs >>$seqres.full 2>&1
>> -_scratch_mount
>> +
>> +# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> 
> involves -> exercises
> 
>> +# btrfs will fall back to buffered IO unconditionally to prevent data checksum
>> +# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> 
> mimsatch -> mismatch
> 
>> +# So here we have to go with nodatasum mount option.
> 
> The whole text could be shorter and clear:
> 
> # RWF_NOWAIT only works with direct IO, which requires an inode with
> nodatasum (otherwise it falls back to buffered IO).
> 
> Otherwise it looks fine, so:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 

Fixed. Applied to for-next at https://github.com/asj/fstests.git

Thx.

> Thanks.
> 
>> +_scratch_mount -o nodatasum
>>
>>   # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>>   # NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
>> --
>> 2.48.1
>>


