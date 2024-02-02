Return-Path: <linux-btrfs+bounces-2059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1272846B6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 10:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D264A1C24975
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0446DCF8;
	Fri,  2 Feb 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PUROLwBu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F2/1+Rm7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92C5FDC7
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864502; cv=fail; b=HzJa+hZ5S0XCFwYiNCzxK8e/iH3RimBSW7bW5xREMuwX1VMX5CNXi6caQ4Bmr/Y2+L0rbRT4wyC+dIDs+TKFLaDZanlBowgo31xkdbXpZVfX8slNeiJhF4OWrnfJUPJwgsNcZ/JApkeCfgBzqrcvutnbBhMA7NdY49f+ScOwo7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864502; c=relaxed/simple;
	bh=jFuve2Kw2juTY37k7Dqf0IGpdg6EdICxxiLhrYX9y+U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5yvFBqmLQl9yKPVcEVQs54Kum3iZDiNMZQ2kyns+SNlvJFRpzHqQFecjdrSlEmMxSw2QvlzofZVFADpfiY7AMXgTcstTZf3JODjsMTB+vEQcCTyH2nqI0oeIX9fEEw0L4VR3IUOO7J18cSdZbHlStsjeE25/uel/ejazE3bl6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PUROLwBu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F2/1+Rm7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128T2lM028345;
	Fri, 2 Feb 2024 09:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iTqzqYCU8MjYlF4d/46xAsz/GQNxC+OIUyGYQBmlxx8=;
 b=PUROLwBu9f1Dr8qCBlHnknzcjo00XHrAN8Fl3vsvJEZHozCux+ysY1p8llyHKGqUjh4c
 itvRV9YDkoznTvunjm1M4VZq+2rM2EiS1i+pFbamb4QBvZ5YBdQB51foZ+7tDxVnBZ0B
 Q7cth4+Vbn4l7uuQps4oLEUCj6WkAhoDqHvGKQ5MaF7D30jpyyLGAKhvUWf/LSx1ux5i
 wZboto1d8UD3C0daSItUYHfitt71rrwSKRl6Zaj41sZLhD9YcXu1upa3YJn+nb6AmBsn
 3NaiIeCwh/YisyIbXLm3iny5RrE2tfC6jlF9N5Sxwj+vt+Q98xbkEqWRZO+Rxjy3Gk7M uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdy13v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:01:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4128Ind4028508;
	Fri, 2 Feb 2024 09:01:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bte5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RILIhapPBbvRhlR8/RWbpcfggHR/fAMBJm/ijzcSwkrNZ47Zgp/E3KJdCyemuc117yEp0bRqFIVZCvv7LNWvfSdAAmtOq3xe3OC4Gbkkmk2za0wpWc6CzldCsHn9+QApzoAL+uOmyTIMIKcNLxcEceSSDHYN5i8A0PWB8IpUYql2l5npsQK4YWnJL/8MMJakKisoY4JmXkvpxbm5qI2Dr880TT9eHvq/gQkRUFG0/HkWzLhHDQZ9cOEuUkOgrICQCrnysZufP8PYoqK88zAMrUWQ7BPOrxVa2i5on7a36WB328ITtzp11Cb6qSwJd07QXST/eSvYow/tT69thJ8nCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTqzqYCU8MjYlF4d/46xAsz/GQNxC+OIUyGYQBmlxx8=;
 b=lptXAdHeIpwE5IqMKczH6Aw5PFj5mb6Ku3vuDWPr03xs0Lg62NnUwUqchcvPVJ3jhLsBRADTSHCKspN0Ju/MS0Z2VVPzL13AXI8HwmZlN3P7YHGCuiOiitDKbUjeZ7/+4BCY83Jh+9WYKlHs6tzXLZ8jcm5uPQ6YNY40BtkhFR4NKva5p3jF8WVi1ZT/hzV7euj/FbpnIwsClY27FzO2FlaE5GGD0psHlpE3fA8nRBRv1Q3y1RnfRQZz5+K9paTXR83cIBgh9y8NYROJlR2k7nOWUgkHeXDaHwCyuQYobj4SDaAZhvdUk0DG3u8ktweMpqdHhh6nKFPeDhx+Fej5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTqzqYCU8MjYlF4d/46xAsz/GQNxC+OIUyGYQBmlxx8=;
 b=F2/1+Rm7fe8TDy+E8ut2NAgXykXdVXBCW46NBWiPRxG52wLZy/x8MZdSiBIo6hmgRYwE2oVmzkLaT7YPggyM8o7RsSmNBovO4Ut4d/ybhKsq2ph++n/neEny9TRROAbcqe3isY3cyvYfchsgWhNyWidqoC48AblgTwWbNtWir2s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 09:01:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 09:01:35 +0000
Message-ID: <8f7e2ab3-6cb1-4390-90b4-c9133de59f9b@oracle.com>
Date: Fri, 2 Feb 2024 14:31:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: tune: fix the missing close()
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706827356.git.wqu@suse.com>
 <aa82c7345596ca6109abc756fc1875a070639723.1706827356.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aa82c7345596ca6109abc756fc1875a070639723.1706827356.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: c262ae1c-df55-4b77-92ff-08dc23cd8eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gRGUwYB86Ecrgj3nXr4LEnZ0jF1GRPRuCsjjMufuIzvEqH1qSCRy2G5+PjeC+UJbJfS7t7V7nkXkhEgP9/Cjw8yYQNGkyWL7czjlhx+grHEulbC664HbrWnRqQClZB/cgsG5wxgEEebUPVEi08Ajea0JiusjNi0sQmAy3jrSsru15lYQEvwtY/dq+sFW8azap4B6Xuv13C6XbkfK4odWiYBnWbRiySFbGpcXfuMRZ4Vs/8XCCTzv62tQrSu1cG/14EGHSmiKBxEzurF2vhPmyng8dg2G8dVRbWb5hV5Ue6ACzi5XIP3d7LS1XNZTaEhksgTuFCHQ1UAaBY8QphAIuNs+ywMyeJP7ZbMm4MFGPloiR07gS8I5DphmcV+UoSphzypAN7PsqBbArt4ZqCiKrchUYl6mRuLhKQvo0BU69HZruteAvFIZkaslQn8+6seLl6/DgLt+tQP7i1gvJ+ypQNYtfF6b6RXXyDa8f7U6n8e8+6Kxw1bcfi0rQ0rNYyRyia8rvwv4REfXc6fO3OCHLpWU3sQoRUpBjALI+BN7fB4dngHyj8WGvE7kfZ6HkLqK3p7nWF6otZ1ApW5izcgGB3AKEw8bdN0XaivsyU8QHMllBHjGzbhqX84MQX+W1s32kgryyM7xvevprc73ajjw1w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(44832011)(66556008)(4744005)(8676002)(86362001)(31696002)(8936002)(5660300002)(66946007)(66476007)(2906002)(36756003)(38100700002)(53546011)(6512007)(6666004)(478600001)(83380400001)(6506007)(6486002)(316002)(26005)(2616005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUF0cEtmeHcvY2Rpa0RscFAyeHg3UnV3dlp4dzdaa3JOZFFEbDZYZ2tSRDZU?=
 =?utf-8?B?YUZ2Z05mOUNkVDJXa3d1SjUycFFlU0hhZjRpMXRHbG9iajV4SldMWFpPbHRx?=
 =?utf-8?B?dlVCdDdGN3gwS25WYzhLSlBxS3ZJSHEzZzN1dzNlTDF3VUk2bWtla1ZLOENo?=
 =?utf-8?B?REpFL0pWL2drTnl2dHJJK2IxUk5nbGt4bHpPTUpOTjBJd0FhR0ZSMmxEY2ww?=
 =?utf-8?B?YndkVlMwMFM4R1ZhZExpUFpmd3BiOXFscDNLdEU3K3ZBOTZEYTRiWVo2Lzc2?=
 =?utf-8?B?MERQdlhUMGNSdjV5ckpva0tGOE9Rc3VCQnZqN2NHbkptdXE2YTA4VkU3Y2RC?=
 =?utf-8?B?UUxnUm4yay9rZXlQUmdDalZxN2U5cDZpSHM0YUNGTlRLVnZSaVlSbU5aV3Q4?=
 =?utf-8?B?Q0pKbHdQTDZJK1Q0VVNjOUtaTUlOVnFtdWdsSndaN1E3cXRlalFwMlBIVWo3?=
 =?utf-8?B?OXFkSHAyVVZoUlZPTU13cG42RXUvS3BNbUsyWE9WMm82b2x3R1VpZzB4RlZN?=
 =?utf-8?B?RXVXenBBTEVOSzhJRitNdkhkUUVPWDY4SW1XRWZ4R1FHY2NUdE1ZdXZiMC81?=
 =?utf-8?B?NmYwdmpRa1BoS0ZYRXRZT0srYXVNVVNmN3Y1RGZsa0JHclR1czRvaTE1SnVv?=
 =?utf-8?B?VkpSY3U3dFBvbkJQQlRMQXE3RWVzTWJXcXdhanBBellJWXdESlR3eHIzenht?=
 =?utf-8?B?dEs2Z0dzdmgwZEd0M1NEYVhUNjFwdWoyN3k2WTFzcEx5SVBubU82WHlEUkJz?=
 =?utf-8?B?clRvK2JLVVlrVVhjNzlwd1ZuYW1SOEdRSFJxTHpIL1dJZ2wxeGdIejdKbU9s?=
 =?utf-8?B?cFlVcE42TEwyUU5MK0h1Uit6SWZkL1lxZzEwclQyN1B2cE9XZ0p2R3lxMk5n?=
 =?utf-8?B?emZzak9XUGlPRWJUQ2Jyem9UZEpqVjNwN2pHS0pLWHJIcmJ6WGZteXpPT09B?=
 =?utf-8?B?UGZUOU0wanF5eDB4RXh0NU9zd1U1b2E0Y1paZzZ5NXJENFJzN1ZSZ09RTnBW?=
 =?utf-8?B?Nks0eUMrd3FTQWIyTVd4OWtqbkxzUWJFVisvV2RaWHpXUFAvaHRHQnQ5ME9F?=
 =?utf-8?B?dEsxbnVEUndjMHcrOHo5T01DZXR2SEJSU1hPMFVDTmZNWm1WdFRMcHBiWE4x?=
 =?utf-8?B?UjcwdVdsakJ1ZzVJY3hFb053SXBOeXpsbHZBNm1zb3EybENPVytXczZ6NGR5?=
 =?utf-8?B?enc5Q0ZIdHJibWhsbGdEa0NhZDM0NVh4K0swNks4aGFxNExDTVc4amtnaWts?=
 =?utf-8?B?dWZLNjhqbUVoaGRYYnpkMHJCKzREbDRnVm5EdGl0YW94aHRaSjI0VE42TVFH?=
 =?utf-8?B?RERtTU1Ea3FueDNzNDIwVjFRbS8rM3JkQnE3VFQyRzRucXd4TXBGKzFleHhH?=
 =?utf-8?B?RGpNcVQycXh2MVVMUzh5ekt2c0ljMlc4SEFnOTFSRmdBZFR5ZndBUURKNFYw?=
 =?utf-8?B?Z3VPNzZxQjNKNGNZNmRXckZVb3llSUFZWlhZN21DdGt3TTJ4Qmx5TjFiTm1P?=
 =?utf-8?B?bUxVenFzeEdEMW9yb0RVSUJzWjEyOEQyZUQ3SHFJMHRacVBNT2JGdzBmdlZv?=
 =?utf-8?B?STFIWnlOSzQ5aVd5ZTdkZWovZ1F2TGlpalB1MExLRnhZbDdxZFkwMVpDUEJC?=
 =?utf-8?B?THVIQVptaUYrNnpYSUtvMGJNdm15c0FHWk1aUmEwdllWb3VnSFgzYXJpbFBO?=
 =?utf-8?B?OGJGZSs3R0JHaFhtcSsvZEdNcEFrTXJHRTBBWEl5cGZROVdkYURVWkJqK0ZE?=
 =?utf-8?B?TlFGRXZZV0wrNVBJVkxuQ2V3RU1BNzlsN211Sk1BYkZHZHpsZWhrbHdMdGdo?=
 =?utf-8?B?VFg3NHpWTGlBeU5ZNXo3dVAzS04yb1RsL001clJqR3B6ZDF0R0o0K0Y0eWJ3?=
 =?utf-8?B?YmNVUDY2Ny93UGJQbTV1UXVxN3RXcE1iUTV6Vk9jN2toQkpHV1lKUXRQWTRw?=
 =?utf-8?B?eit1R2hVcGdwK3Y5NG8vOEVOb2ZqU3NmOVl1d21jdFlQWnhvNFpwVXF3WThK?=
 =?utf-8?B?VVAyelRNVVovbTlVVWU1dWoxamF0QU5TeEtqZEdVKzg4K3NCL3BpbERVdnY0?=
 =?utf-8?B?aUxVaGs5TVI5YWxXbXdaVWNGdHU2dWxycjRGQVNBbzU2SDVqMndzVThPZzNJ?=
 =?utf-8?Q?JHqGQ+QrC+Ecm9UZP8nV+0bW3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qQHmzdhIaVvIXE+RNHV1sKWAf9vrhY0UsDyUCeIvVcQ6D0cPg/+6+6a+mlbI0MFXvQBoKiD1SbBKMAtArbc01APPfMi9IVNz84fSTdmbLosV0sfcMnGWTUjz2aqWv4rndE37tCJ9yeGe61FnevLOqEzs0K8NsonfEtW7Op0+T+ChW721LGPm0BFw1JBuuxcR3/yBogifP2v5Ma3IFOIPxY9oKWHZVjCqcZH9dp49jOdmeoZdTQeh/wuj0Ll1hXJ9BFK++xGulISZa190hbC1LdMQZ8U1pWHSAWT/htSdP0WxsOC1QI74NCBzlcmuyQ3bUSfxwx0GeIZmdaWjMSrcrDMGJZLf4Fu0o054keZBwrESTga3s5bF8TdAGc6PVrp9pyTolmaZ6pBZeWWEwD2oZIOSFjzPppscwWX0LqLGYp0IMdhjYtgCbO4BruAAXHyB3oy6URW6hYd71lq6yx5DaFdS4s1ERgxuY4LCi35CpurlMbh2FfzwbOmoJBBEVxWkQrTVCEYXbiByi41I3cf/K92hU8bIe5n9yS9ctrafopSAK/T8t01D0iDp8PDIBbaARRMhyDn4FBO00m0iHp8+ScB7C6W/q7bThKh7wsuTLRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c262ae1c-df55-4b77-92ff-08dc23cd8eaf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 09:01:35.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg8S2lsQkLQkKGS3iMfSnLQayijRg2gWyqB8I+AVs9uaEfR+/4oQdE2P3+XJSVLO8Nyl2OwN+TXEPZ249caYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020065
X-Proofpoint-ORIG-GUID: aLePK9pHjGKVyJEzF7IKRu5Z21NHVLcg
X-Proofpoint-GUID: aLePK9pHjGKVyJEzF7IKRu5Z21NHVLcg

On 2/2/24 06:29, Qu Wenruo wrote:
> [BUG]
> In "btrfs tune" subcomammand, we're using open_ctree_fd(), which
> requires passing a valid fd, and the caller is responsible to properly
> handling the lifespan of the fd.
> 
> But we just call close_ctree() and btrfs_close_all_devices(), without
> closing the fd.
> 
> [FIX]
> Just manually close the fd.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx. Anand

