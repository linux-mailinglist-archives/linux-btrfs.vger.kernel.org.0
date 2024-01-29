Return-Path: <linux-btrfs+bounces-1927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E78416EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 00:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483CB1F24A1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D420524C7;
	Mon, 29 Jan 2024 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTDt3nTr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nXw4eTrN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DE51C31
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571213; cv=fail; b=aNfOK3KelTEbiH5jtkZty3InoBzMHCXFHOXJR8E7gin/GAO6VevpK4pvX0+/IJPc+1/sgTJ8TTcaVTan/gDadsfUrpKKpGrJ+zcCRMZ4L/GXWtKxGQlE9FGGdjAsqtqMJB94CMtEaF5Mw+bKn1O4pXiCmLVtysXHd+oIu+GAjJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571213; c=relaxed/simple;
	bh=CzNoelDBi7UDv2YCwgTb6x3z2wPMyI29gezfb+2+Vvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uabOdPyq1KHI6a7a1tHcq6ihX6vVU5SjNrcHS3+vj82Fj1cGApppd59uG54NL46RJBG9Ef2XWi7Pngc0v4dZbINuL3kUR57atF169wbDG0tSiaLRzecp2koovCZfziw+BcJeIlthCizI+7+6T06KOQdSr39XnA5UvpCb+WT+vXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QTDt3nTr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nXw4eTrN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiRtt004400;
	Mon, 29 Jan 2024 23:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=c7n1vnSQRT3s4lSqDAporTXo7CzMCN7xVy4GwfpDZbQ=;
 b=QTDt3nTrGg0O9NWZZ8X7koqwpMJM67Qdn7ctUMNxNTqVTu0lOMAvbvOF3acbrW7jZPRz
 jXuxPkvcZLRuvA1WpJSUzGeiyIOK3dZzABaoWOldkjGsJ3qDvaDUfgnh31TXjKbWfy1l
 yufX4k3lM+uLz1Y+jAiKZYCxvbnmAtypyAKCVWEV4JRFbAeCp4FhWSkwVB8JxLKBIZEb
 aEemBVndADASYMQNClF3P46z2Vk4L3xWMKyUW44ZP1hpBd7lD+2yxIoHC+Lso4ql9E0w
 rJBNPQ/ZwVQ+pM1241Jger2joZBbM8Kbt11JeGAQSix0UKnarLyRNNNf6r6eRZuiGPMe Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqaw7q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 23:33:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TLvjJY014573;
	Mon, 29 Jan 2024 23:33:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96bsnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 23:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIUP1HmbpdnWjf5FGlsUquBj3MBLs/1Qj8IfyUL/4EB3Bh2ZOKyVtxZCqVXNZ6caNkUDuHNoIUmZragnNbO15gi1FvsCpIN0PNdqLCbwAqlvvidkziT9I5xuCxhYJ0Pk9U8Wm2Uf0icBo0/LegVoHNRlqmsmHXJMzm6qUbPnMMva3if5BPKyQ8AsPouGcLIXr8yUBVxlEN2wwdfe75uTEXfjSv8xBfxt7oC0yErFPdKAPpzT2dMk/3Sv8lO+aEwMeTUeQdVuB/Vf2ifAYh6ikJoFC/vyFxSdDf1fsuzs1ZkZUo0cliVIkZ/AjDFpAVje/bO0Gg0BCKDGd8gTOv2i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7n1vnSQRT3s4lSqDAporTXo7CzMCN7xVy4GwfpDZbQ=;
 b=lUqG7F70NZJ/uZE92lMLbwZ1YbjzeTML/B5Do86FM7R5HQ1mLqDN8/MD0+BG7PLGfxt9vzZGdZbWEVGVp814SAVS+/hlPIfAH+9l77LTxBr8BcAosBDZHGxBzWEWVpbTPrKN9axrSYRSOxSEAK5eRw0746WDHTKU9V55v+pyOZPOICM7nLacmW3zDkOAhAT2TpBIZ2Kgz1aOr9Z55B3iPeL0q+G1bP196Ebt0mSsIW7s5gR+SwhYPd3bJnOmbsODAl9jANESY1FKM/2ioFC6wqArHst9LXxl2t3pX4sHNbXU4dpWmCRDFFh1d1bkF5XJmMHuWFtW2OOA5UyNjfnVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7n1vnSQRT3s4lSqDAporTXo7CzMCN7xVy4GwfpDZbQ=;
 b=nXw4eTrN8geN13G8tP9l9ak10LhN+YoECdZaBf9z4yWjifdxE7oKVHESqU+vxE1mwnWfiA0ToFq8IYohB3BDmT+cCnP6CLdtaojVNQwXyifWvb/3gnvge9BDnjbV2Y/nm0bxwyt1G8Z0nZe7QLMFG8xHQ10qAS4sNrCoU/5BNrU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 23:33:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 23:33:12 +0000
Message-ID: <7c2b141d-f5df-4343-807a-b3c9b613e5b0@oracle.com>
Date: Tue, 30 Jan 2024 07:33:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Error handling fixes
Content-Language: en-US
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <76160d68-d3bd-409f-88d9-7723a1e4e9d8@oracle.com>
 <20240129161309.GA31555@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240129161309.GA31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5723df-a8a3-4e41-546d-08dc2122a8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lvCnag387Lj9+HyKliDEKbhJeDRW8lIq9KFExtjsDKMDkyyy8WQtsIeAHEhLS8Sy/MNek90auRp5WF+afUmCOtNCul9QW1klJmmg3CZ22M1nRsx3Woe3B27Oh0BbeEDmHTfn8vOc3ot9+nJO74M9DuHm4KCEaKcVo/hOMJJW1hm/efjVtyJfeEOCbFe0gXDPP7WKwFjNoNsMrv7JJ2v8BnQLeYdQSkHoIpYF3Q7UjNncRox8g3/n4KfNvDrFSSv4dLhqbiG/JHbcfbBp2+ZrZH9G9zcRvpD1SmSR2bYMXLamFHQjjSu/8pLsoabeuG94GcB2sbJoHmmE5a/a70R708vJgDncncVX3nvIaXbYLeUgc4yTrDcVIj7Q1hThwUGGkScfwnOyrWB83p7KfkZw0OP2l9l2UDisGkSSxlOG73vQJB3kalFW29tkhWT6fSfAZk7BPJu7aIMUTnfPOqdfmN9J2EA5j38bo9v9V5qgfZlcqQsvHgzow9UNPE/NzS3TERARzrf9IKyKP1HvsoSpqo3/bU/E+dAhmZ36Nr/SvtTS9nuzDD3n4k84ysbpleeEb6NcYJP4nLJJab2GTlCrLZsrdVOoRleRjmk9vZQHt/zXkw576ncDud3QjhPG6mYS/TsoogDE3gREuAli7IHfpQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(36756003)(38100700002)(83380400001)(2906002)(41300700001)(6666004)(26005)(6512007)(2616005)(6506007)(53546011)(478600001)(8676002)(6916009)(6486002)(66946007)(66556008)(4326008)(8936002)(44832011)(31696002)(66476007)(86362001)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1Q4V0FvOXFnRXpsNXduQWl2TzVuT3RoTm1CVlU5WmN2QnNkL3FCVVd5bG9r?=
 =?utf-8?B?NG5VQkRkZFpkbVhmLzhJejNoTFZSQ09pUjdHUTZmbTZUNnZKVnZIQ2dLQ2dJ?=
 =?utf-8?B?bm5CU05rdHBUYmpjMk5uSm5tZXBISlFsKzV3NVhKMmlBaVZ1djlRaTVOS0Fs?=
 =?utf-8?B?Nk1hSlVUT05lRmZkVDd1bTdMTVpUb1RiZXEzY3dudnEyTzBIOXpxallUTlFM?=
 =?utf-8?B?T0dhRTZaRWpJb3ZpNnJNYVdEd0tHcjRjdmVuU1J4aTI1YzhqdmpLRWxXYjdP?=
 =?utf-8?B?VUMrcTkzWDVBdk1JNlM4N1gzVU9NNEVXbHYrKzhLdmprZGZ6czdlc1d1cUts?=
 =?utf-8?B?Y3lRQSs1TExxMXVOY1duNDJIR0U5SWJDcWdSWTJhenB5MVZEYXhBM0NpSzhX?=
 =?utf-8?B?VHljL2l4akNHRWVPVm1odmFqUjMrTDhsYllOeUpEUTdqczMxaWU0cVBuL0Iw?=
 =?utf-8?B?bjNWV0lDcHJGazZNNUhWc1kxcWtOMjhzelBVRWM3MDdjaU9GNjlXYk1lRVlx?=
 =?utf-8?B?QjRicW9Oc0NxR3dsZXRLSXk1YW1DS3VRMStnNVRkYyt0VlloOEhtcHF5R1FJ?=
 =?utf-8?B?YnBJT1dWbjBxUEVEVTBNV2xQWlZOK0IzQldYeUJjQm5DQVZUSXNDTkhEak1E?=
 =?utf-8?B?MFJzR1JOT0dCTGdSVWt4NjdUcy9DZVlra2NCc2IyUkJEc0tuU1hva3VlSTll?=
 =?utf-8?B?c0UvanVWVU94QlNJd2tRREYwa2M2RUJ6OVhTb0hnV0hTVkl6MER5MzJ5cHRH?=
 =?utf-8?B?MWxibDR6OG4xeGcvaTZwOCsxS0pYdkR3dXdZM0pvT3ljWktPQkpDYjBZQTlN?=
 =?utf-8?B?c1NralUxdlJtWktLcUpKOUZpZUNDajZNTVBFejROK1RBc3dVa3dmaUN5WHlR?=
 =?utf-8?B?Z0k1SW4zUUdTSHZuK3MxZGJvK3AreElWMU9pMGdoQkExamxKMmtITkIvRUg3?=
 =?utf-8?B?YlVTNVBabkZIYW5MNjZURGlFZis1MU5YeUdqOExFQjErYmI5Y1BjMEVPeVB5?=
 =?utf-8?B?MWhrR1VEUHErQ3JoVG9yeG80L0laYVlxem4xMXZVdjRQbVM0WWk5d01GSkpv?=
 =?utf-8?B?d3pUdUowYlJCWTV6LzlCTHgyV0FvUFVCNjN0OVF2Vy8xRDlTNDQvRFBJblRv?=
 =?utf-8?B?c3FqQ01INDdMNXo2c256QTcyT0tMT0VYZ3Y4bm1aaVJWb3c0bGY1bzl3VUxz?=
 =?utf-8?B?ZW05NWZFaWZsL25VWDVaMUowOHBnMVpSRDQwRjR2d01EWVJ0dWp2bHRxWVR2?=
 =?utf-8?B?eVJFS1J3UWtIQ2JvOEFrcTU4VmIzWnpwTTBtQU5WZlFMSnBzWFprN2ZlSGhz?=
 =?utf-8?B?ckxJS1JRdGNiaFAxbWRVWlRuQkNpSDhCNWpkbzl0TGw4TVUxQ3NvQitlVFB4?=
 =?utf-8?B?UEplcmZybmMzaFdVU0h5V0IxRkRkSlMxS084OE9LNjBLVjlHek1HenJDVElB?=
 =?utf-8?B?d1R6ajNCVFZwR1BUclFBelc3QWNzUUFwM1Y4d3hObldXeFZseENTUU1GYUZS?=
 =?utf-8?B?Z0NZaDg3SktSM2JDcmhITW9BaDdwb1RteWxqN28wTWF5QldJUUQrbkVwalNE?=
 =?utf-8?B?TkM1dVV5RndIbW1pWkRmdDlIS3hZWkg2Q2U5WVBYaWwwTlhFTXoyMWpFaEFs?=
 =?utf-8?B?WkZ2TmlUWVVFcm5WVHBLcmhDRzhZWTRlS1krTXQzZ3B3V3VvVTc0QUswVXZj?=
 =?utf-8?B?OHRhRjJncDlVTkh2M01RQ1IxbnIvelNkeUU4REhPbWdMc2tRWlRQRTFXaWlL?=
 =?utf-8?B?bzlMWGR2MjMxaXFGNm5wd2tBVFQwVXBZNVQ5QzVNUUhIZCs4amJnekE3ZXl2?=
 =?utf-8?B?c3RPZExrMlExN0pjOEc1b2xuTU9GY3V4OEszVWlqOWxLd3UycVlYTlBkVVlx?=
 =?utf-8?B?aiswRmhXQVZjTDE2ZHZjQktxMUhLZFhTSVNYRVRNMTRpblYwUmwrR2loMTFS?=
 =?utf-8?B?SzR2QW1LUmppUHlncEFialpiN2tRdUo3V1htM3lhNndjYXQrSFVOQ0tWUCtq?=
 =?utf-8?B?VzBjRHRzTXZnbmQ3Q1RPOFdDRUF6ajRPNHFIbGZNU0lLN0NHZkcyM3FJc2pa?=
 =?utf-8?B?RVFDenczMmlNVzdnQnV1Y0lhMmhmOElWSG01Smp6N0pJcFdrNC9rMk5HZ3hS?=
 =?utf-8?Q?S5izMCR68DustyhBvnyUvICKx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mG0IUJuohUNMIT1sNGeIsP99uGA0ybD+JRfkQpdq9Q1rhP2tiqLxryDw5DQf+6/ZIFrDWiBGzpnAoo5hHdYM3VHUUujV5iR5bnjR6XY91Ev22OME7RBXHHCtmApQ2aFsrbf4cnHyKIAgGd0pT0aSquRAIizWmeWCVOysXXj46nPqLgHFQd/OjsYuqPfwm63Wojfy68ykHNPHXiiVRxN8d3ZbjYZw3ZK5Uy9AqrHAGhjNbjU/pl7QeU7NA+20QTkUoTb/7tCc9/lwtvoER0s05zgxvzF2ANB42s1OAgvzzjvm+/85Z/HlEjyIWVwdcNqasevch6m4zzgqK4WoGgeZQ5NpCaSGokXBDVG+Q/gRVJbKttJ2j81aa7dgKOfeU9Po3UEnbNQsH5u0yn4xo9GT6SYwUZb7Pu/82c8wkrGn7BQz4Lw0lbRci0EklwQLVLhMciwhYF0eYvvl+BnlMzibzSoF/s3+L1JdbfkcqJXgOQUfMLb+lV20d5x24A+1UqU5ZvcejOcehY6RqMbJfS+iI5PA9I8pyS/bl43vYS7ymwulunqdYhNJcTGgVTSdLKvDrMVQ/egdd2OWoer2rfxp3Vsyg84SqY0rg92Y2CKhS/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5723df-a8a3-4e41-546d-08dc2122a8a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:33:12.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMJedGPKWzTFw9NYXq6mrzYItCsMF89Q49M8ulnaFoMSGQSPbnQh6sWUoyF3lXDwohm38GazHskLM3DQiTwYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290174
X-Proofpoint-GUID: Gu6JyPQ9F-s3De1YpEwAaHN8UWFwePXT
X-Proofpoint-ORIG-GUID: Gu6JyPQ9F-s3De1YpEwAaHN8UWFwePXT

On 1/30/24 00:13, David Sterba wrote:
> On Fri, Jan 26, 2024 at 08:28:12PM +0800, Anand Jain wrote:
>> On 1/25/24 05:17, David Sterba wrote:
>>> Get rid of some easy BUG_ONs, there are a few groups fixing the same
>>> pattern. At the end there are three patches that move transaction abort
>>> to the right place. I have tested it on my setups only, not the CI, but
>>> given the type of fix we'd never hit any of them without special
>>> instrumentation.
>>>
>>
>> What is our guideline for the error message location in the function
>> stack, leaf function or at the root function? IMO, it should be
>> in the leaf functions(), so that in the event of a serious error,
>> we have substantial logs to pinpoint the issue. Here, despite -EUCLEAN
>> we have no errors logged, in some of the patches. Why not also add
>> error message where it wont' endup with abort(). Otherwise, debugging
>> becomes too difficult when looking at the errors due to corruption.
> 
> 
> I'll try to sum up suggestions from the whole thread, the proposed end
> result of the error handling should follow this:
> 
> - critical errors should be followed by a message at the place where
>    they happen, typically next to an EUCLEAN
>    - an exception could be something that is called frequently and the
>      messages would flood the logs
> 
> - transaction abort should be at the place where an error is detected,
>    assuming that it's clear from the context that it's unrecoverable and
>    no rollback is possible (ie. free structures, undo changes and only
>    return an error)
>    - this also needs inspection for special cases and exceptions
> 
> - tree-checker verifies data at the time of reading from disk, we can
>    make some assumptions about structure consistency
> 
> - error handling should cover all possible returned values, as an
>    example search slot can return < 0, 0 or 1, although some of them
>    might not be possible on a consistent filesystem, all should be
>    handled and return EUCLEAN + message for the "impossible" ones
> 
> There are already examples that can be followed and copied elsewhere,
> however we still lack some helpers for the EUCLEAN and messages
> pattern.

  Some of error log might need a rate-limited messages.

  Thanks for the holistic error handling in the next series.
  For this series:

Reviewed-by: Anand Jain <anand.jain@oracle.com>



