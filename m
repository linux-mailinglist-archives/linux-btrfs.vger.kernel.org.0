Return-Path: <linux-btrfs+bounces-4290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4858A6117
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C264E1F21E71
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB92107A6;
	Tue, 16 Apr 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGCP3C6n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AW3mLf2H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE6A35
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235221; cv=fail; b=qTsaB+owjMjI0YgAVA6h482u8qCRuh0BBn9EeqhF4ffRXEbqt7iPg+Mzwc3kZN7LQASdfl3VD3zQGa5EnFQy04Hu/VFa8tCkIu9hsVFCPV/HUlnRlh8I3lUQhWMauRZ+kf31h9PNrXctsGpgtu6hX5miFZC9Aj8338/tvC9MitI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235221; c=relaxed/simple;
	bh=XZW3Ww96QKp2cOV6/PSyWQ68G08BOPVbykfo9riKN0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mQVMO2BZZ5s4h3alRv9wN/s2n9iNEgumGRj0g2al0FwjEm0jtDtoYkePIG3C/an0Sbde9UbutZLEpHrhMAr3cornZlF/i3o5JMFoQTFr2tF1GLIcafWoJvF8yXCcPh9qS9esD9PoRxtF133gK8sig5Ex5LWJRpZ5+FfBdVbDcJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NGCP3C6n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AW3mLf2H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G2eHFE010343;
	Tue, 16 Apr 2024 02:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dI+Bpu/544uD44JW+dXp4cjRzxabR8hOpTzlcv8FtIg=;
 b=NGCP3C6nO+AjaFGbeKX5F2pO6SvtGzVmQUm05ou542C1499SBP/azf4WlHO4ubuq/9FG
 itiqAXsGnfkaSEW6zXsM3fs0C50r2gwWQa68/VEXN82a6BXg1pzytAklX2rp2YJk6+Yw
 Nw77fY7OzTArFXPlC5vrK1W7vDCKolz0wKn5Nt24tiid4NOMjScbXHUTML244SgqYKab
 URy+P4EwtdcD266ixDKRXBsdLr3X8dZ98IVy6WH2aRzmaqdr33/5eMl1Bpbe0R+sc4zF
 5AkXtMpbgiPWJQWo6Ai0yd0vl8KtwCd9h+0HKinvLEa7E1ys1zG7P34UrgBOOwbViMcV hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffc7u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 02:40:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43G2B8Ld029186;
	Tue, 16 Apr 2024 02:40:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg6kga5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 02:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsOgQkeShNfw4AsCBx/1QhEDYlnjWHgz13lmBojNMWrUs8X3GN0KUmtOuyKuuK7qZcF2usguJ5QkvA3iwFugi7+wpbKOvKfvqVZ5X0hmFFE1096aSXpKrLAiUBYPs7lqPA3fymwbgp1/77aobwxtf0P2/4IGN+omTopYiKqPiYinxvIzWFXBiSjHcbWLTu+AKK/OXcsE9OyuP3iftO37tt3b+2LUu4Cu0Das7cht9U+sqfRlvN56XZXdTByFMqpqdrKqicGika5oVF1Fd4R/l1XKPTkdEZfiKDwU7Q37zqALQVZMX7diiw0JPiK3L/jj06Pbj7Krd3N5UGUPGREfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI+Bpu/544uD44JW+dXp4cjRzxabR8hOpTzlcv8FtIg=;
 b=g5vrBt8C8ZiScrr+cUKUMc2J0Z0sTHII4AV+Wxklu58az/36D3XUuxawEN0lHEtFuAUlEjqkiqLfBw6B26yHDPZ8BURACX75CdD+b4XnxvQoGTBQabZzv77MUhRw9iytNQtW4ObG2l9cS230AuSKAjp4dJpk2cgY7W4c8AGf37RR09fpZ8hL4ex2ZofZCAGHOJOW+cZqlxIL5lEM2zLFv3FM+YZ/Rg6DdT2M8ZpjWq1L71suMYOcDyt8x9SAFDjzaoml6x+YOWatnmEIQlwBzel/+Fa3H0Ml1N2LtbJ8z28fkH9L79eRC4rgNvV2X2OJOSNQmrTGE8in4Dc/MTv/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI+Bpu/544uD44JW+dXp4cjRzxabR8hOpTzlcv8FtIg=;
 b=AW3mLf2HnZteplRTukhHOyXKath0tyM/iq7jCUcE2ZEYdtdZZ8kLENrXcoW8GpqVdtjze+MZ9HumS0PCLtBikBuIsRhESYq05mJZX4daQQkYPIz1gxkc5mMxwFua0DH/oLPD48cR4vJK+xNgN/cJ2nWziEi8FZIG8eYZSftqLkU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 02:40:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:40:03 +0000
Message-ID: <600cdd17-44e0-4198-b868-d520bc553807@oracle.com>
Date: Tue, 16 Apr 2024 10:39:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/29] btrfs: btrfs_write_marked_extents rename werr to
 ret err to ret2
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
 <20240319175327.GC2982591@perftesting>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240319175327.GC2982591@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a13057f-01c7-43cf-c447-08dc5dbe84a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fAuI9md3W4cw2VL4IBI453IrCYzmmOhZcVvyJr0kvviTQs/tyhyS5dqs4zleoPL3lilKO3KZmNzMKpg3iELnZ8+qdP3BPd7/Ik3OQAhoL+0NzHvSHF4UYA/uMcQhI9U/7LvyDkanMdBkzcGMxfceBGmESWq1txp0t8e5opOeJIkY/S0bZvZm4RYRr3G3RNa9HZijuV6szzaFN1dQSOIVcZyRE+dITlYE/Rl16va571puPOdHre5+nfl3FGa8DR3KAzR1P1MzTS9itxLjOQkJkws0jpE5DTFQRR+Al4xXSZGUXw+1oeDbQprpsHR22iRfdMMOTYDA+B+F4yznxSmtgIoyYJiJWepDMGnWx9Dr1Yvry1x2Zrxeezq9eoEiP8RO5HztqO2rjUxALhni42KOEKNCUM7T4CiGvtKPECPPvGRKanbcPpbowkRRPozICPHtRSCy4W4mxYdxVb7WQwufFDI6l7TJXRMDDNUSr6p7bOt2+fACe53FjbbmAqvJ5evV/xUywTM3AsvflfZQJafanbqmNduzrPEUfM8wKeoSk+6JJUrJc01kvk+okh6NAhw3ywS/J++3fsNcvJ+cVJTp1ZnmFoH0Y157TiEjG8V388ENEF6QLwhGizSjJ+dNgAWkpciOepD+4VHIJBm/0c6TZWbervu2WjuCUUJ39Uvt8W8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXBDa2VtUmI4NGpDYlJzZktETHJTdlhFTDg1QmlFUU9tOG1uMDk2TGpjTmlm?=
 =?utf-8?B?aCtjTkxUUXRRU24wb1praE4zR2pXbDB6M3c4K3ZoL1BsRzVVN3AwY0t1R1Vu?=
 =?utf-8?B?T0tqUTBvVzU1TEZoNnB2RVRaWFFiUGFjaWgxY2RHODFjR0pjak10REtnSmMy?=
 =?utf-8?B?bnVIeWFVN1pZcGdoL3NaZ29MdW5NTXdZZHVDWkVBeE95WTdVRTRzdmlINjF2?=
 =?utf-8?B?T0JZcU56aG5rN3FxbjN1TEpvbThjOUNUYmI2Q0RjcmVvQnhOSXpScXdlRTB2?=
 =?utf-8?B?Z0RNMEJoYlhqaUdyRU1zNmdPbDhJMEJ6d25CYmNibmxKTFV1NmxaKyt2anJu?=
 =?utf-8?B?WHJ3U3BYR1gwOVM4YlEzWFZSL1MrL2hhWDcyMjJ5VnpmL2ZVUXVWZXhpN1o1?=
 =?utf-8?B?TEMycXVQVUdvbU5QeGpOckxTOWtpMGltTVowdjFMMDlmK3prWUNVY3VPc2pL?=
 =?utf-8?B?SmZITTBNWUVFTTRMQmJ5aVNwTEdLeHR5dlR2bzZQLy8vVitsaXQvQ1VNdEZ5?=
 =?utf-8?B?SW1NcTk3b0gvRDBJRERKZ3lQbjNpWVZsT0FrZGpWbUJXb0FsKzd4YW5GQjcy?=
 =?utf-8?B?aXR3dGdIb3NJaE5MbHFadnVVN0RsUmM3dWtLYllQZmtVaVR0eU1PQ0V2VXlG?=
 =?utf-8?B?cEc5QXFSY3o2TFU0bUYrbG00RTZvam1LWURsdndEYjllYVpXblR6ZEtNK2ZM?=
 =?utf-8?B?ZmpxOGJTUjhVKytYREN0SHNhVmNXaGp5M2NheEYyMTcrWGxQMmRYeDBKaTBN?=
 =?utf-8?B?blNpT09Ea2c2RkZNcjNxUGN6MmJGaVgxekVjUXNJRi9pNVc3ekQrTW1DNEhI?=
 =?utf-8?B?Qm1YYlkzbkJvSVZrSHBNWGZmNFo0U2FoVGNBdEpKdkpXdjVHaGlZeS9ucjVj?=
 =?utf-8?B?RkR4elJQTmJGanRvS0FrcGl5bks2VHE3eUMzdkxYeUZWUDZacGlxZ0REZnBD?=
 =?utf-8?B?V2p5VTh6cjRvRVkzdjdITldqNGdlUlFnWlF3WGJkOGhNNytlWnhub0IvalM4?=
 =?utf-8?B?V0hyYjEzeG1tLzdNVGNHdEc0VEc1Zm1TUWtWcG9rNlEvMUIvalNxTjBVQ1dP?=
 =?utf-8?B?M0Z6elQ1L2VPYmc3NFViZHV4cXpYaVZUWlB4SlYzVGpWVXpoclJJUWxZdTdx?=
 =?utf-8?B?cS9haVpaS3BCaW12NUlZVUIyb0h6M0ZubFAzOWFNZDcvQmtOcGN4MzNwb2Z5?=
 =?utf-8?B?ZzJlZDl5Ly9EcFhVOEl6TzU5RnR6STBsWHZla2FmQUs4blZQOUNMV0tKWTF0?=
 =?utf-8?B?bXRFMXFPK0kzdFlvVS9IcTdIRmxhYXpodnVzNmZyVkppb0prcVNuamJ5MkZE?=
 =?utf-8?B?NVdrYTB2NERqUmJlbis5Vk0zQmNRbStrb1o4RXR1RklhRm5Rb2VVSllFYVdp?=
 =?utf-8?B?UjNKQnJNVnRnay9wS0hCcHg1RVpKYThmSjZMT0lxdldvdXBuUmdqZkExekE2?=
 =?utf-8?B?TEJiSDdlTmJDSEtmUXp3d21ESmVQaHkvWHBsekl1b1ZFNVJCYXBHM25hbGEz?=
 =?utf-8?B?Tlh3NURtQm5mR3Ztb3o0Vm1OWmhiVjEzTEFBRlloTCtremJ2WkgyMUl5cFQ4?=
 =?utf-8?B?NG9DQ1lnWVVYQW1YSC9WMCsxVk9YZXBWb2cwSjdJYlhTM1pvemlaMkIxTWF1?=
 =?utf-8?B?TEZxdjNVY1lnZmdLNVFFT3VBL04yd3NCdUQwb2gvRldsVG1UZTBLenZRd2w0?=
 =?utf-8?B?U0pUY01iU2syeTNMcXZPbXlHMWxCQ2FSSUxjWjhTaUpqNzFwalc5OTFUSi9u?=
 =?utf-8?B?Vi9xMHNOaStUYS93L0tRanB0RGdkbVBXaks4dXRHbzNxN2MrSi9xTUdaUWl5?=
 =?utf-8?B?TUs3OHdEMWcxaGNOTkgySzNweUltTENlaEl1SEx6anJ4dk9UdTJmaHFvRGF0?=
 =?utf-8?B?bnVvNXYwVDZsbW8rUDUrTkppNlNkMlNxelJuUGFyUGNudHR4MU9IVUFLVmJJ?=
 =?utf-8?B?SlhkUXRLTmF2Um02SFpLNWlPbEloMG5GVGxmSVh2TGxPTTNnaVZBZVp5R0o3?=
 =?utf-8?B?a0o2c3gxOGtjYjlYZEw0K2JheGJhTEw0RjAvVnVZNklGdGdKMUc5TU5ZdnAx?=
 =?utf-8?B?MjVJRmRQMUMrYmZubVJ6KzhMZGo3UkZZMnhHd29IS0JyYkhWZXBNeGdCUXVs?=
 =?utf-8?Q?dR6yAHol4cMmGnOw5dni0LEIp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mmuQYE6qRsLA7wcUPQBWv83CEwGeybJkY5Q8Lcjony74rpuKctsAb6yyu0evHH18Slu3aFCPaVTyF4aLZA8eTETP11VdK91zfgwyqcxelPp/f4nOyqFV34qMYB5xiXkqV8dWW+fe1FY0cXNZaEDqNpQ0+SDSjro89F/NV6TOQUvoA+IsBR3Kl+Z6KGVOqc0B3JJbMSndF/ordmFzN1/vCxvWE1qNQC61QZrEDUGtAKFGzgkigyu7MAz0Q8UL7TElon8Xur9KScRfqCAlkYHjQSLNRNg7j4get6na4YbcMqSGoElbBowHxvQ2gimvdfyRrZKqQ8fUsgGooHgiFqccWml9sLXs3jso1V0vRfzRXU3VSZ8VJTa4DU2LVOfw2WczwuMkqgsvkT15ifadX2IMjmK1/JKrNU9EWuGP+Ec+1x2J2VTXdkAPphYd5qoE4ROO/cF118IRhhRjBDznZ9LmB0y24N8C+hMD3sCdHuNkPGeii1ZGUXVfNZKU4MhoDAo72teRS09to2oIro0Lc8eYJ2lYSUWB0uYMr6oyaslZQagZVcSZUcJydsJ4erYAxOunHP5aamFC0vIjCrFwA4Lx/i+TrDD9TNZ6YyX1bWEtSe4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a13057f-01c7-43cf-c447-08dc5dbe84a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:40:03.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORKVR7YB+e+hvjWlWhjvNRKQOdOQ1iS8HJ3crKoFlnT/HFEvYAlBX0ZLgp4Ec6c+drDvwgsQsdsW8WB3D8cVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160015
X-Proofpoint-ORIG-GUID: akEZQg438tXYNqz-fQEd5GOLDjyZtYQP
X-Proofpoint-GUID: akEZQg438tXYNqz-fQEd5GOLDjyZtYQP

On 3/20/24 01:53, Josef Bacik wrote:
> On Tue, Mar 19, 2024 at 08:25:20PM +0530, Anand Jain wrote:
>> Rename the function's local variable werr to ret and err to ret2, then
>> move ret2 to the local variable of the while loop. Drop the initialization
>> there since it's immediately assigned below.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/transaction.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index feffff91c6fe..167893457b58 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1119,8 +1119,7 @@ int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans)
>>   int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>>   			       struct extent_io_tree *dirty_pages, int mark)
>>   {
>> -	int err = 0;
>> -	int werr = 0;
>> +	int ret = 0;
>>   	struct address_space *mapping = fs_info->btree_inode->i_mapping;
>>   	struct extent_state *cached_state = NULL;
>>   	u64 start = 0;
>> @@ -1128,9 +1127,10 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>>   
>>   	while (find_first_extent_bit(dirty_pages, start, &start, &end,
>>   				     mark, &cached_state)) {
>> +		int ret2;
>>   		bool wait_writeback = false;
>>   
>> -		err = convert_extent_bit(dirty_pages, start, end,
>> +		ret2 = convert_extent_bit(dirty_pages, start, end,
>>   					 EXTENT_NEED_WAIT,
>>   					 mark, &cached_state);
>>   		/*
>> @@ -1146,22 +1146,22 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>>   		 * We cleanup any entries left in the io tree when committing
>>   		 * the transaction (through extent_io_tree_release()).
>>   		 */
>> -		if (err == -ENOMEM) {
>> -			err = 0;
>> +		if (ret2 == -ENOMEM) {
>> +			ret2 = 0;
>>   			wait_writeback = true;
>>   		}
>> -		if (!err)
>> -			err = filemap_fdatawrite_range(mapping, start, end);
>> -		if (err)
>> -			werr = err;
>> +		if (!ret2)
>> +			ret2 = filemap_fdatawrite_range(mapping, start, end);
>> +		if (ret2)
>> +			ret = ret2;
>>   		else if (wait_writeback)
>> -			werr = filemap_fdatawait_range(mapping, start, end);
>> +			ret = filemap_fdatawait_range(mapping, start, end);
> 
> Ok so this is a correct conversion, but we'll lose "ret" here.  Can you follow
> up with a different series to fix this?  I think we just say
> 

> free_extent_state(cached_state);
> if (ret)
> 	break;
> 

Sure. Checked the function's stack will propagate the error here back
to the parent functions.

Thanks, Anand

> otherwise this patch looks fine, you can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef


