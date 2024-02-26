Return-Path: <linux-btrfs+bounces-2765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400F866A0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78CA1F21A75
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D11BC5B;
	Mon, 26 Feb 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="beyouBHM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fI2MlMnO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810CC8C7;
	Mon, 26 Feb 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928932; cv=fail; b=tFDCQVAwuNsfphTxS8/1x85dUIr5V7hFzWvzPvCIxSmrDFs+eU0VDEi8moe0GJSVR7omHPpdIk5W+ZdIAYlCP2BYn02UE9XeMgwI9hVmzLm77UbrodRs6XiZcCAfIoGb8dNTNwqwK+0ix2PyGsPckvCO+XgZKzYuAi0MCJgFsxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928932; c=relaxed/simple;
	bh=wGaN2FQcIBdxqLoB9QSweWaAu2Pj0PZethqUah549pY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5qqq8xaVVSwoxODglhOVafN3vFnY0idgjG/vmCOXRwaY6zvNN2C6kP5JYQpSbL4gAHAPh7Rwz4dJzo0Sd4xzO8h1hHLwxH9Mepq0/AANWFwIZ+mZdQg6zJThj5KYRiD0uIdirws7wHTC3BgM7zigiZp7AJm6+4G486r+K0+5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=beyouBHM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fI2MlMnO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41PJkx6i009672;
	Mon, 26 Feb 2024 06:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ozQjaIAd3WV8Zlac+HkGmmNfn5kBgJoD0qvUD5df4YE=;
 b=beyouBHMsgmqUo9BU2oLaedQb9xX9RUtWvLMDoiWDFpw4qA2sThEQ+e6alPgne76U+0t
 dfzZodeEKX63hiray4lS7tvGGZlTvcD8cREdmpCtIC1IOTPlzOHoHFJE50JD06d5fIK5
 Xou4NPIgkUBwgmgrBzxrGLJz0v9DDDYVaRPX5Nav7Yxnw9M1yDPFsH1k50dtExl7HB9L
 txflhvZUPT6lc9RwGHSFZc26EMH8J+NOdmP4vKkIzz+jlV3pT93i9PdLIqJxiHvURpq8
 /yC3FXJAtTlSFubDdKZtzH/EhF/BrEGNa9B/UAFS6cetSxsO/UosnQemKAKAMoRUYlZW 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722br8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:28:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q51ahF039302;
	Mon, 26 Feb 2024 06:28:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w53eb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 06:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrUAvYSc9cc0uFwOODmvgj3dqX7CI9wmesUlhRuMBJWH5zztgtdvSMhMs4v5DvxSJ4i9Rvv87fktSPJvQhdNh0VHuhukiTau7TlB2t4JJEjeQXtSnaIMfiOD/njMWycymuWg/cJCpEo5BOh2j+F4NKygJ3VpIQWDn20v/OMCbJrxeQ78+MpmWdU39pRvjgSKyRkerBfjwdtmkG3dlWM6Uvpms7k4iPYTBvV02hVNE4kFS0w54jH3NnhW2dCOriPRsA6z2QZPFbe+W/lOVg6FTV7Czpgd0Taog0/ALnG4Ndt6Lm/KMLAx+zMSizcSlkoOiaaAtgteKeMnirbpfP5wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozQjaIAd3WV8Zlac+HkGmmNfn5kBgJoD0qvUD5df4YE=;
 b=TwzMtNy1BnL2Yk+sAtQZVEmDhairjoONsEFhDOsFMJtIe03zkK9nGjZ7YgUAgvtMNmJsux5Dsrn1APMTGMzv4IBKeXZsWtMfP+8RfFhwYxxcOUBm5MJe9IKH2Aah6PeiPRRz0j7MATY+wjUszt6JynAQ9jO5qNIgMNvdwIoRcN1YETSB/fFtwo6tvqHglZTrN+wuRKZgfAFsdMaNv1eaNCaTlvsLIIO47TYhK/jJ3lphwfEtpyz2jLzDNSQmArUp4IyTBYxFhvQ3eCGIGVb1p2Qd3uqZmHGINa4gDoCnDOH6sYgyg+3SxhY5YFsbOgsf8L1mS4oqNS1zGxLuTPCLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozQjaIAd3WV8Zlac+HkGmmNfn5kBgJoD0qvUD5df4YE=;
 b=fI2MlMnOeFQU3OMfbMMCVptOcfUcxjX4zKcUrJ6xHpvybeWMQxOOzxefC0EdS88zmLER5lKR27fWYziwKfilo1JF2/VRQ+xZjHgT+S4K3/pdczewkudxoPtup/pQJdU7QhrfxGBfKYZ3iBK5cautJORLDirxLTSRHOHMPSAzuy4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 06:28:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 06:28:43 +0000
Message-ID: <e4703a32-9b16-48c2-b5ea-9477be071a9b@oracle.com>
Date: Mon, 26 Feb 2024 11:58:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/224: do not assign snapshot to a subvolume
 qgroup
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240226040234.102767-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240226040234.102767-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: e24ec9d8-6124-4d3f-9181-08dc36942dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oLoFTmpI2BPmpD85DSaxMM0jvCANEpdp3+zu5e89Wu3uAC2ijgMv7AIsohiz2JwQSTcYwEZIdILd/1fq3V5r7pQl8za3IZuTyJOTUw9gva+cRg44vZgGV4bA89Qc5ACl3kjRolOzjmPMRpovYGcNDS044sIpBGC/rCJymR6T65r4k48y+J5bf3L0Ie2Pak9tEUIG4w6QpfJlOSjLJc/+5fvyYY2OO9eVZ5MY9O4VRYGu05RQBqogf5und4sMfA1x0Hie2YQXf3ahLfDWXZg85IDqQKO8L2RRYAiFUM0D6ttcMrI6ei2YOjhFNKE5kaFAY1iQI+HM6n3gMiE17OXjZLSXWZZsoPM7dtgu/sRdCsFvoRU8dvoaRHCXYW6p3ty41INjPQMXeZT4/PwXGFPGAGmJcwjJ/MTrX4VNjcDZokVY3U2ROZqsFiEFmfSUS5cN4BcEwldIQyI5yNtsf+yyh7oI4YQySb4BqzXu2t4xOqN/vc73GScSLUZsqwOr51r6nLDDNGte0rCrYX/y83/HMEdP0rLWP6+PRzT5yLEng6RGMC1ghiBbvMOXQtmcRgNjXqIEuz9kf2ZKq1jxHi7zajvT4dR8LbCA1uLQF5T9baNDHNaPNpZeMkctx8ApvGEZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THZWUW12UGtPeHJjL1lDMVRseGpxTmltUkptV0EvaUg1ditBMmJDcmh1TEFt?=
 =?utf-8?B?cUt5NTlHQ2QxcEk5RHY0Zkt6eU5SS29xSFpYR2c1dEJQc1BDdEE1dG5XNTNl?=
 =?utf-8?B?WHBFZ1hveGdjaCtpb1h6bjF0a0tKbFJSYW9hUWV5VW5nSlZXTC9vNk0vdnN6?=
 =?utf-8?B?c29RU2t0a25nMXBQWE1PNHBDWm9DZTJydktZMTJBZjhqZWJ0azluanh2aUVF?=
 =?utf-8?B?MDVibzh0S0FXTVZWcjRlaEFIM0hWMlU1Zi9PY3BzaVhVd25mYnREVGxONks0?=
 =?utf-8?B?cjN0Y0RtOUVMMTJQR2QyTzFzS0hvRHQ5WnFKRUdoYTQ1Nmk3YXdkR05LUUho?=
 =?utf-8?B?VFBaSVVYN3RTbDM0bzllZ0tCL3FHT2RwRnAyWDcvYytkUXdSQmVIemJLWXc2?=
 =?utf-8?B?SGVVZzBJd0w5VDRwbHgycFBQMVZ0UjJzWXlZYWhhOTF0cE5LV2theTFjcUNE?=
 =?utf-8?B?WUI5QzQ2QnJSbmVSTm54RHVQVUZYUmo1YzVjdGZtbHB6QXZPM0FRQ1ZSa2lx?=
 =?utf-8?B?MkI2YUNjUFpFR1RXUVRibUJlMVpOK1c4bFhkY0Z3Q055eEFqYmFLcllXTitF?=
 =?utf-8?B?ek50MDJSaEZ3S2ZhY3hCdCtvdHZ3RXA0R2ZlaEdmdE5Lak5XdmtUMGNIMHNa?=
 =?utf-8?B?bDBmUWNxV2JsMmtyczdDT2xqQmUxZXFCMk9rQlBWSW5iN3h2MndzVDBBNjVS?=
 =?utf-8?B?RW1uVExGd1V2S1FyZ0ZSeS9rdGJGRHFzZDFMQVg4OGg0R1pKUTFHZkFjb2Zv?=
 =?utf-8?B?NnQvNTBVN0xEVHhucVkwb1dZV1o2KzhLSVpGV1dxZ0dxVGhYZkdnQVFDS2Jo?=
 =?utf-8?B?aGZEcmZuMndHZVRuUDZrMERmNjVSUjVBQTVuK0pnMlFOOElrS28zQ0t5TUVj?=
 =?utf-8?B?OFdIQU9kUXVJUmcrZUk0bUxTQVRkMkQzcktYSjk5Q3ZNZ1hIU3o3M3Vuc1Av?=
 =?utf-8?B?Sko5KzhjajhxVk9rSXRPK29KcHNnT204QVFoS1FSZHBzUmcxNWNCQ1Nqd0xQ?=
 =?utf-8?B?eHpTTFk4SFBNT3YwcDY0OSsrVVZHaWM0RkVtajNyZ0lqc2E1eFNJQTExY3Vq?=
 =?utf-8?B?VGp4cGhacjg4Q3BxNEtVb1lzb1dCaUhNVzNyUytiOCszZVdyWitwUWEyV1Jy?=
 =?utf-8?B?Z1NTbVhiaVJKRXlyUkUzT1ZHSWdHT2NnMm4vZHNlaVM2WStGYkJ4NUVwVGJL?=
 =?utf-8?B?TVhERFFkYmRlelcyUnhweFBaazF6dkZ3czhjQjFxbXJDQnF3TUxTd0U3LzQz?=
 =?utf-8?B?Qlh5cm9Pdnd1YlJrRW1wUGIvZTRWSm5BRUV3VFRHSEFYL1V1M3F3VlpMeXc3?=
 =?utf-8?B?TXJEakJKYmRHTWt3ZzY1Vi90dzB3cW9SanFKYnFKb1pYRHIwbDlsZWVmSHdD?=
 =?utf-8?B?YVJHendpbDVhcXpQUUlndEZyR1g4dVd2ektFZ3BtRE93S0RLVXBwVVhOd0U4?=
 =?utf-8?B?ZDVhM1huekdialBxcEoxV0R5V3FhSzIxWWdkM2w0UnFCZWdpRFhLaFlFaE1O?=
 =?utf-8?B?MTVXMzVFbnpZdW4vcGFFUFkzOE9hbVRSdTFFU0FlZk5MVitWUVBwNVBJRVc0?=
 =?utf-8?B?ems1TDI2YWgrQ2sxS2xlVjYwMC80djVQRGpWNjJMYVBxVGRVdDYzVDNSUXRW?=
 =?utf-8?B?RmZKdHZla1NXVU5zWUZxL2lzUDlZSXBBS0tNZ0pLMitQcXBxeW4wTjN4MWly?=
 =?utf-8?B?RTdBVHMrOXhHcExkMG9mL0l4MUNpK0E3aFFlYTR6V0c5bktmSy9vTkJTOFNs?=
 =?utf-8?B?TXZlTGo1Mk05eUxJREZEU0hlWmdyU3YxWnhwNnRLZmE0OG5jVVhUSUdOSC9K?=
 =?utf-8?B?Q3FVRTVXd0Z2VjFxU09FWnlrb3BnV3F3ZlhtYzN2angyM0FOTjZ3US9Ddmxz?=
 =?utf-8?B?ODhXSHVxbFNqRjkvOEJ3RGRtTUdkZXk1cS9mRlZIc3JwZExlbC84anl6SnQ1?=
 =?utf-8?B?MUNMdndYMTM5bVI5TlB6eG5iNGNFbG5PNWlyc2Z6MThRWm5MeFlaL3YraFB4?=
 =?utf-8?B?bkNaRXUyejlPRnYwRXVPaEpDVWMwSlMzQk1xaURKNGNhbjY0d2JjWUZReCs5?=
 =?utf-8?B?SHdvUkFLREp4Ums5K1kvK05YODZpNmsvRmJRR1pISExzY3ZHaWx4SmV1QXF5?=
 =?utf-8?Q?84U2VYsWDXj4bA1q71n1S+4eX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BgkED3xldjLQr/sxdmSV/DDSZ6TDmoPE2si4CjBnB2iP0tOX8IQ9csgcOeH6SuJq72cA1ixFM+D7bTFENgVMYFv0+zQdN7+k257v/coJWdY8n7qgu3GUdIvMTHkC7tScPmdK+Bm7llLT+NMHt47soSEXIqf1J0DplA81op9uUsctbyKoZzj9klPEuvL5r2SoJmuPV4GHFaG+kryHzSD5H7kET12AccgC58ntTOhLy5JKF/4hG3msQpVUJ1gLwnKSnsIc8QsfT4pVY6d6e8LVwN3zFccLJ+jv9+Xk1mGA4mv1qOo0zVy0LJ+sQt/ldWDpimZcQk6ipl3wkh1zFJSWnOPBVY4/qsoGKc1Zg2YIGBDLG18GAYOhYpeJYMT4nEhmuS0IyWD7uHPL2ly3cAbvRPdnpCSrr+28JP85V5MeWv5Rcdf9N3/KjuZvIlYnCLu/SJt4NpO3pW1bJo8Hm5fuaw4X5rzuyTPO5mpVZTdCTjLgG7P38nMRGRAgeuAkg1rpkB3SgO/pvw+FWectPxqvRl/+XjycpR+U3vV5k3KZ4aTqoPX3BUiSrmZUlFeN3F5EQGo8x3kPsXkZwUv5Ncis2O/Rq5BleygMlsddKu5vtvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24ec9d8-6124-4d3f-9181-08dc36942dd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:28:43.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T02J4zHSQbpZjn8+A7H4/jEboycDC0Wvee15EeSaYWMoNzm2isOjxSd3xv51asMbd9RqnGoDSmuup0EYqs5A6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260047
X-Proofpoint-ORIG-GUID: mH0QPFwbWkWQ-HlA5jP9hgTecLNzOg5o
X-Proofpoint-GUID: mH0QPFwbWkWQ-HlA5jP9hgTecLNzOg5o

On 2/26/24 09:32, Qu Wenruo wrote:
> For "btrfs subvolume snapshot -i <qgroupid>", we only expect the target
> qgroup to be a higher level one.
> 
> Assigning a 0 level qgroup to another 0 level qgroup is only going to
> cause confusion, and I'm planning to do extra sanity checks both in
> kernel and btrfs-progs to reject such behavior.
> 
> So change the test case to do regular higher level qgroup assignment
> only.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

  Applied to
    https://github.com/asj/fstests.git for-next

Thanks, Anand

> ---
>   tests/btrfs/224 | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/224 b/tests/btrfs/224
> index de10942f..611df3ab 100755
> --- a/tests/btrfs/224
> +++ b/tests/btrfs/224
> @@ -67,7 +67,7 @@ assign_no_shared_test()
>   	_check_scratch_fs
>   }
>   
> -# Test snapshot with assigning qgroup for submodule
> +# Test snapshot with assigning qgroup for higher level qgroup
>   snapshot_test()
>   {
>   	_scratch_mkfs > /dev/null 2>&1
> @@ -78,9 +78,9 @@ snapshot_test()
>   	_qgroup_rescan $SCRATCH_MNT >> $seqres.full
>   
>   	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>   	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> -	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> -	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
>   
>   	_scratch_unmount
>   	_check_scratch_fs


