Return-Path: <linux-btrfs+bounces-1184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17C821827
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 09:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7935B1C21565
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA83C05;
	Tue,  2 Jan 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aU+r2p3T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I6HoIxa/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5620F8;
	Tue,  2 Jan 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40200aZL010336;
	Tue, 2 Jan 2024 08:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U6fBKDgSrI1wtFkdnwzPLTyrB8VuJ6r+tEpWGLnxXO4=;
 b=aU+r2p3TPSLqgLdp5FmOKdjhiWTgPN7d4PYLzfj5qVcrsvP1+XutQLVX+C7jw/Q9abjM
 S71AdJw1JhOJAF2lesNaS7duHRbXhFmEt2KLiC6u4DsVnSS9MDW56MxMPIVJSwWW6CBY
 xVyx02kS9dmLGBBkQZJyODenqFNBKhyCWZJ9aRCqxH1t0/WfyrL94EMTHHjVcyWgmMUj
 CPS7IPtI/lq9Jj9PF0XjFF4YIr+jZlfxnfV+J5HoWvv64HgBkym9uXrrcShHlItjX7UA
 NuO+Mr96Qwtze5oc+vIMIFFIp2aJQ8cZd5wzkEHnPzmj4a8OsNABFXZLWiWhNHNPLCLA ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3ath37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 08:01:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4026ZBFR036123;
	Tue, 2 Jan 2024 08:01:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3va9n6wkmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 08:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6CaERHfyn0JBiyPTMX1QVEsb5IOyz6NiQ9RTwycXBVbeNlBDeNyYfySYoQmVB66T7oy/kL+eNYSeC2lpzR+Lnch5wqH+0seTmZPjdo7ISUrd+YDW7EmG6gfDNKbon0dPklYZfEtIWBqETN2yY75Dd4RfSXY50SbKeFgjd8idEjFca0kd4dRAomYlcpN+FQr21z/ahYw9kK8T0EO9liDmQ5L1k4AlyJHdngG2OlHJE83eePQVJ8tr3aHC1RbXVI5SiR4Q/RSvhNEBtwNYBgzPW+1KmVrNiJ3u0R0bIycLJgysYIsUu2he2HFKywbKvPAToJ5T9I766vBYp8Ji0h03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6fBKDgSrI1wtFkdnwzPLTyrB8VuJ6r+tEpWGLnxXO4=;
 b=i9EZgUpB253ZcaCoYdV6rmm5NDuJxjwTvnDQfaXf3rhWqRajS/4vvudoCBp0chunrc2qgx8hT7mw+zMfV1ApKmHdkIoAJnxstfvwFy7xMvh7KribGZ85dGryniOYnLAbV3QtR6u6bb1HonvlJv9A/tZmtEYHaLzf3Xrg+i2BBDMkX9ZyKcS/AY0j4YR9OmEYzbD2eyaCLXmWf3uRiqVmS0ngQ/0/x1P1PyYL+yKmyMsrSLw0mophGs5uDR0X3W+KYeTthkKWyjd2y3M8kXwlZLotTLQwtv5d1IKq2yLeCuOrWQv2UDVkZ4kRh1qwudQpe7WouzDnoHr7jXdLgvcVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6fBKDgSrI1wtFkdnwzPLTyrB8VuJ6r+tEpWGLnxXO4=;
 b=I6HoIxa/xGzXSP8JFf9yB6fIfaywM5kOF0e8gh6lvUztm7iP0Yi8WyXAbDe+MOdjO7vorg5fxrXQguGwVqzMczCT+sM+PlKxHKRGxixSWN9DM7GFsb/XQFLpO0/JTipncwKu/OM/CszUOovLEMrh5r0JIN06vSVVksTjT7cIF2w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:01:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:01:55 +0000
Message-ID: <0cf6e6a1-c347-4dd9-98cd-4a95f36c84eb@oracle.com>
Date: Tue, 2 Jan 2024 16:01:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1703838752.git.anand.jain@oracle.com>
 <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
 <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 692796e5-7f02-4f8b-ecb5-08dc0b6915fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8a3bQXX/ShlZrb9gOw2wH/f2ZuTVpr0IJuPXc+FnD6Ke1R+Jqd2K7NaFclCrEV0LdtBs43pLW9Hfb3FY5uZ8IbSec6sCxPrGZ049uDHvIrihei8nRoPhQrqfNx/OReZfLa3HCxXwd65NmX/M7x8cO1MJKEqdPHnwBtXA7IL7tj1777UHDAt+ji1NCpqs8Z13P81BvB0bEmg41VMamlpCO9krrsaGbypoOCLLbcAoO3AlbhTFzE2YSSqNGb8NcQFDwo/2skNFbnaDxWanfThrwXVPXJvIGDHaiDPLO9y+Mp8sgACKA6Lmza9cw0ctu0RzxHs2AkALQJwTb2nZKNHd/mg6Z7P38tjJk46+uxtf0rDeQwlCNgIpCbKsFw+FzXL36jOCysPt1SEieFfPCSYdIWQtVVjnxPSLuAdZo+7nJvW1+w1JW3ocOi4u7Xr7BF5DZD6aKzDQCDgnbVunkYLXiMsaYfzjcUQVYIhTNNuW6ydx+gXnkJZ5STZWLEe0a4hyKkBa6wL83Lfa7QVBtuz3wbXiY8gh5JfBdOgXd5kJlmgZY391rJhJm8wigVzcWKfigZSJDtdBvQ+QhM0Z/MrwTI9G5J8XUEuFN0iKz6Oq1MuubIBr2/xBFgiadaxVM0zSa9Bs68FqIN85LXTnqNr1sA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6506007)(6512007)(6666004)(6486002)(53546011)(38100700002)(478600001)(86362001)(31696002)(36756003)(41300700001)(2906002)(83380400001)(2616005)(26005)(44832011)(6916009)(66476007)(66556008)(316002)(66946007)(5660300002)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bk5UcWlaTU1DbEdLRkp0YzhhM2xMQmdUMlFFTUgzSjF5NTZUbmNpN1lwcDA0?=
 =?utf-8?B?QXVSY0lPOGh0ZlUwbGNoSmwwbXZTYitXWmdZcEJia3VTRGphUWQ5WmRYUS9r?=
 =?utf-8?B?UnlmOHdLN3dWOEYwK0JpTCtOSmxqZThhYjhjZjI3YjVhNnBZbG9DWEJ3VGFN?=
 =?utf-8?B?bEQyRTVWN0h0M25sSEJoeHpiSFJOa214dW9RcXNCbFNZc01UVmZOUVNEeThW?=
 =?utf-8?B?bWkrcjZET2haVy9HVWY2SnNxODR0aUphWFFRU3BjN29HOENnOVg1R2YvdGdo?=
 =?utf-8?B?ZllWWEtoSWV4emU5ZVVnMUFWZlFxZ0pJUGxmN1lmL0Fub0FkZWhnN2hJQmFR?=
 =?utf-8?B?N05LR3ZxMFZ1UlFHdzQxbE5memtJUUlqOHBPRWowQXE1Tlh3VUFmMEZkdWJQ?=
 =?utf-8?B?djhDakt2Uk5MRXhHWFJoSzRjYkloTWtEZmpWNWVFdjEzVTNNYkdvVTVLekJE?=
 =?utf-8?B?NnFKbXA3SjNqb0NERXFZNTc2WDFuVVpnVXFqL2N4NVZGZnV3MHg1My9VSVJB?=
 =?utf-8?B?ZmxaUDNlV3pWdmZxZ09DTThodDVkbWVyR2xSUnI3d1hMbnhNZ3lBczdJZDl0?=
 =?utf-8?B?NjYzNTNRbFpFSzQ5c3FZSkNVWHJqa0tNRENLNVQyWSthNE8rRkVIMzZWa244?=
 =?utf-8?B?L3pLdEhQci9RWmprekR6YWdXZmNqUVphTXhCMFRVWkNKMUlGU1E2NytWN0l5?=
 =?utf-8?B?aXhrM0tYYXlLQ1BiOGcrSEhkdVVHeWs1TmF6aHFCSU9TSTFVZ245YzN3T0VJ?=
 =?utf-8?B?WE9DdVFZRHdoWENESmM1ZW9KTUNYSzlKK1p2WWhUbm9oZXdRSlFwczVQQW5v?=
 =?utf-8?B?eSs5V0dOSXpBSkF2WmpIbFZWeTA1TllJalYvS3JqeGhTWEpVU0JwemFqa2VR?=
 =?utf-8?B?aHZEeUxNTlhJZWg0a0N5Y1RIN1R2UzNWTThCRlVoaFFmT3NMUUZaZFhnN3hE?=
 =?utf-8?B?SGZjYmVaTDE3L3R1d1lEOUN2N1YxNnFqZHk0MlZSaWNZTWRBMWljVzBnZ2JZ?=
 =?utf-8?B?MnNLdkVrZ1hRdWYxTTIwR1lyM2RsdC96OFNKeU9IM3lGQkRTT1JxcVR2Y0hE?=
 =?utf-8?B?WDdjMFNIZWVWR2N1TWVHY2ZNcDlzOEEwMGtLOXgwdjBLV0FZSUlZTkdQMlMy?=
 =?utf-8?B?c2JHMGhBSVkvM1ExYktXTjBHeVg2azRjcEt0a3ZhRTVGOVhucUJjMWIvMGRO?=
 =?utf-8?B?QmZ5Y1loakk0MHJzdjBuOFdSeGFIRVZGcmRBdFVQdXd5RmdKQy9Gbnd2Mk94?=
 =?utf-8?B?YjRzZFo3QlRhK2ZlVmVGVndxMWQ5VVF5a0pYdUhWMmsxUSsxLzcxVlg5aTY3?=
 =?utf-8?B?ZXpwZGJUME9lYUJGeW1mYjBYemN3bDRFTkZZNHFMY08wODBYa2lsWUZwYi8w?=
 =?utf-8?B?QThQcjR0V1BLSGYreWEvUEZrYngxNUVpTng4ckxMaTZia2tpS0h4aVo5VDNS?=
 =?utf-8?B?emhSMTZuelFrSnB5T0hxa3Yyc3lkblRuU0xIQzk0VEVzNFQ3YkFyaEhXQ0hF?=
 =?utf-8?B?T0ZxQ2R2ZVcraDlnRTZUenBLNEJVTmdQRjBxN1R4ell1d1lWRnY3OXdlSFkv?=
 =?utf-8?B?VmYrVzZvTVQ3aklrV2FHZGs3alhRbnAySlJrdkd0b1RscVZETTc4WWdUWFBE?=
 =?utf-8?B?Sms4OWg3OWoyRGFwM3JwRnBWNDRLd01OL2hXbFIzVmsyUU1vY0Y2bk82MXEw?=
 =?utf-8?B?OStZWFRjMENwUTBncGdvMSsvUVFVYndsQ2dLL2pSbnlxNGNMYy9DOUVMc3pX?=
 =?utf-8?B?SjdnSG5YWjc3ODhEcEljaVlFOStYMXJ3UkRyR2pwUjArNkZPOXJVbWdQY0Qv?=
 =?utf-8?B?N295a0EzSDRJcHZ1Y3BCcGtZa3RaZ0pBUFBUaVRFbUNoT0tSVFRtWnlTSEp3?=
 =?utf-8?B?a1N3R1dlbjR5Z1lPQ0Y3aXM2VG0yNzhCbVhqdHdZU3c1OXZHR3N5WDFwcGhC?=
 =?utf-8?B?SUxSUXhjWE56NTdzbjNTMGVCTlBST3lTdVZFRFdlS1AxTjVNYUxjVVVUZzdS?=
 =?utf-8?B?dVozMVFzODdEd21xR2Iwb0VYTTVVMWdZTXp3SG5mcTROb2xNSU1ITkZlQUhK?=
 =?utf-8?B?a1lPWktrTGdoTE95RGV5M1V0N2lWTzgrWEV0Zk9lMktITFY4Ym8ydC9PeENh?=
 =?utf-8?Q?DsQHFnI3oLh/o6auH3TfoIq5w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qeegpniCOuZqOvjGQo/TrVZ7juTRQ7sBZgCy4/EaQCOvdJHYGtgPWV46iYbfAh0vxoq0Yol0UImIl9yd50QdfK/HCVJUlou2PdGcxMlVfkQODJvCcsGSZEQc5AZzpd0+CWZD4jWxCh0z9ZU2rKtaFdrG7IQrOMG5RpZkrHqoxTNQJx/qYslpEueaxLLOIRrxhsGnJ50A9GRMJiEryIoALMXsfyBlmqKTYxLXKDuhr9I7SK3A54sjZ41b4C/5Gdl9VtrFKUpkChhfDvPJEcMWC7ZZwQ6hNqLrIZKLM2qg3rZQhFfMzmdAKu28Cj5DMJufHtXXIEht8k7z2PpwP+W+XaIwoDE/RrA1SWU/L8Brs6H2vC9UHH8iQkfSg4wxuEBtnWVvq7zABWyt28EUFgHx1Lo6vTdaFD0O8EirxNBvbsuQlgzd2/aRJblB1B0r+/EmUMlMulysXS7Do7H0sp1HGMBdmCd58NklKPJUpY+7JIRNjDWNtr3JongoXHNB0j1lD/F4G5yDeJh8OOLaqvfDLuoJ5SwCfTNz1eLX+apU+ehevc6RO8KyyeN07PJbsDkvboIOW7TJ5XZLl1wvu/bOblUpMcMMsGieKGRy7cB79Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692796e5-7f02-4f8b-ecb5-08dc0b6915fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 08:01:55.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgLXWA8UEidm/8OV84wQXl2ozkDF2r/84vOacu6C4Xz8R6zU5yOHAEvakmEpd2y2bIPUBrHX+cmJihPa+aKbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_02,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401020060
X-Proofpoint-GUID: QUF_niIOEq7Bh5zkITwtdldLDo-TPTah
X-Proofpoint-ORIG-GUID: QUF_niIOEq7Bh5zkITwtdldLDo-TPTah



On 12/29/23 20:57, Filipe Manana wrote:
> On Fri, Dec 29, 2023 at 11:02 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> The command 'btrfs inspect-internal dump-tree -t raid_stripe'
>> introduces trailing whitespace in its output.
>> Apply a filter to remove it. Used in btrfs/30[4-8][.out].
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/filter | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/common/filter b/common/filter
>> index 509ee95039ac..016d213b8bee 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -651,5 +651,10 @@ _filter_bash()
>>          sed -e "s/^bash: line 1: /bash: /"
>>   }
>>
>> +_filter_trailing_whitespace()
>> +{
>> +       sed -e "s/ $//"
>> +}
> 
> If we're having such a generic filter in common file, than I'd rather
> have it delete any number of trailing white spaces, not just a single
> one, and also account for tabs and other white spaces, so:
> 
> sed -e "s/\s+$//"
> 

  I'll amend.


> Also, since this is so specific to the raid stripe tree, I'd rather
> have this filter included in the raid stripe tree filter introduced in
> patch 2, _filter_stripe_tree(). That would make the tests shorter and
> cleaner by avoiding piping yet over another filter that is used only
> for the raid stripe tree dump...

  I kept this as a separate function so that it can be used elsewhere
  when needed. Doesn't that make sense?

Thanks, Anand

