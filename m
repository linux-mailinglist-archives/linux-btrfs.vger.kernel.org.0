Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B9687881
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 10:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjBBJN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 04:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjBBJNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 04:13:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F62010D3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 01:13:25 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3127OCxQ002024;
        Thu, 2 Feb 2023 09:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AjBzomvAE31kB248yal+Ber6sM6uSAS0gb6G0U76hb4=;
 b=A4c9zLzC9GjRhwco5c6HIyT9yZmnp9AsueReq10oZDQP6lTnd0SHw35ezqEtnqbE3aac
 RuMancstxkWR6rxg2Fug/QtaHQKg16CzVj9oCn+ZEt4F7PpDoZpce6QcB51ZbxnFbtXn
 ugsseRr697mCShVkDez6uhgLckwPPAbmN4S6anvuvRhckHbZ6VgZdiQbghU8OrhLF0Jc
 ZPmM+S0cTyuxsMz3bem+GyNqd1OkOVrXvgrJRcYnq6f3zJ6ChrwF7S8akGkh/MagPAMB
 mrS6Biot7+vHDiRWdNbJhGKgoTWZKW07VuBYUGeWy1aLP7mWoOpiLp74CNzoZe9qSYu8 AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28ta1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 09:12:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3127jW7r003777;
        Thu, 2 Feb 2023 09:12:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5fw35m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 09:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpdYKerHlO6HFJ3SsmW6NjHhrnyIRNeQm0V8ZF8cM7ddoK8awHD0gIBl9EqRJK0H4oJlF4n50eXo8mZ+mESU16LP6exbkC0D8wF557GrW+K8ioZc8Gz8RSvwxBTv7A7x4tTqWkpe47PjKaq1aigWT5AtEDifrHL0LJzKn0O+148CvwOKMhYHhhsfN0AT995kx7ssb24tjArNJCqWJK/p++N+FRnqFz8ZohmMbnGHzFHfzsQYIZj/poVcitEWdm5ymPsj761gkCZPkm8+wIqTZPLSf8pW1krf2p71kV4jAyBN/HzG6gtsmlhlAqPPjQv8TGTeECu9Ev9n/iZVozZbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjBzomvAE31kB248yal+Ber6sM6uSAS0gb6G0U76hb4=;
 b=C+ukUkukuRmLrVMIetXsGKmEjKOjhH1d+HtUkGMZQJKgldHroxo2xRa1ZXKY04/VAp5+jvUfLRwBExWz463lh9jyr9MrmWtwAxyDpM3MKBSIXvLMxY06VAa3A184Nrtzg5MjHJUxN38t86qyQXS1KRH47mhJ3ak6+zohE1VH5QlAv8OdPbppCvLTeOnVzry40OnlXoTu3FPhZFLjsnWCNJl7BM30Y901Us9LKYBHjGsvhHHlw9Gi3Cse40EIERq6bdlvPkENfbfZbInUvKAT1McLW38HE8axS4cGwh8atV2NFy1sXsT62x/4dvVP08S4rt01WIRJxVBQcxLiwwS8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjBzomvAE31kB248yal+Ber6sM6uSAS0gb6G0U76hb4=;
 b=muCDPbIsg4QXCyPy/XBK2RUaUWZhBjSsRWjZkTBO7DiQHidyafg3UdKlgaebVNbWNQoVesLYwaWb2V4SoAEbsOqSQNILTSRcNgNiA4kZrHX6DeNVEHM4CpziVgrn54VBCyptuOVvmPvx7vDvKtsTPxz6dKz1b9mAlH+/aOqyCBE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Thu, 2 Feb
 2023 09:12:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Thu, 2 Feb 2023
 09:12:30 +0000
Message-ID: <aec522de-683f-b673-408f-8380b206309e@oracle.com>
Date:   Thu, 2 Feb 2023 17:12:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
 <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: e50f3c10-43f6-4196-df95-08db04fd9c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6WEddAckTwrQECuYAz0gnYNCGwdz7JdOxPBatiFUfszhyGJSQjAOzgZcIg4NB/heMgVwnz2jPO/zEJGc1HdbpPYMfgrmwa5Z1pY6//kx9RqSN2oM2iJAZKIYEmtFekXcsFX0TY2PmHBoAhY0liALYm4qtnnrHz0EyyQEW6EN7XXHKmcoj22BwgUJa29OVrZaVug038b+H8PR2qkiT7IgSN4b68rnDhskw0ZRSg824dKymrHRoQN8P9rDVOGW7KYwEFE8RePtD5xYN1Trne5jAQMfMV+8NfDnFY1zmPS1tK74eygH98BCIi4ZIicLpZTbgduw+4OO0E579LdD+47Pjj9AiFhD/a7JRZAoWkeXNhKsIRMPqBPwSUWEE+9bCykWqMlOEdDQdP8gGm64fLGL5NpMku/IA0sNIFcYR3spkyQbw8uPxZdqqyq3TJn5H9u9Auzb3qm+4YGC6/p3LkmLHTWWGCBTlXX3Y8XZE9cNwXS2sxgS/HiaRruNJ8H7eEa1WEI4jFeNVfFoo1b+SB/tKdMg9A2jn6OQhOYJxB95xmZhiTIgQi4DvNGu2SGhrWqW7UHWfbU2DjjKGOiYqfcIXb4txxN5cG/CSc0u8KKEI8hg49oqwCSwy+ecZvHBTPOZI85Bm1+S86oZvzcUzsOh8Ekgi/zDg0ZuZS6YwPXhvPhmKaYjBncpgB3I8VLMOwWMH76X2al1alTl2P8UyC3ISYIal1PuqwJnTdr+7TM6t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(83380400001)(86362001)(31696002)(36756003)(38100700002)(44832011)(2906002)(41300700001)(26005)(8936002)(31686004)(5660300002)(316002)(8676002)(2616005)(66476007)(66946007)(6666004)(478600001)(66556008)(6512007)(53546011)(186003)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUp2YXRyOGh6ak5GZmhQR2FCT3RuQU8xdEp2VEpqRDNJbSttQUtqa3drbWNu?=
 =?utf-8?B?SnUxc2NUeGFibTk1VGNDSTNPb0tiRjhmZWozbjNMOTVjV3RkMmRuUEQ4Wit5?=
 =?utf-8?B?bG5Na0YwdHFwa1Y0aENIWWIzSHYrQTMxMUVaeDdyT2NtdUw0SFYrcUdFeTBu?=
 =?utf-8?B?SXhhU0VybE03WTZ4dFRoSktKWnd2cUpDb2l3bmRESzlIc243ZnlXOFhkTEts?=
 =?utf-8?B?ZjUxSmRseGFPYUxyaW16K2JDbTVydEtkcVoySURUaDgwZ0tXUjJoTE1qcmlu?=
 =?utf-8?B?V0tHeE1oeGJXaFZTQTJvb1J6MmIyUWF2UVN5Z1IxTEFYb3FTVFFMY3RhTGFh?=
 =?utf-8?B?djlXRkJSU29OeXNRNVdoaGR3eU4vMHcrQjRjakhhN2RtbzlDaGtPeTBobzNX?=
 =?utf-8?B?RUt4cDZMK2VacVhwVEFSeisxUnZPT054enVVWS9jV1U1OWpPKzZkK1RWR3lY?=
 =?utf-8?B?M0tIazJybFhvLy9zaDJxSVhJVlI5V3hncEZnOWcxb3k3SDhvTHJGKzFWU0dV?=
 =?utf-8?B?VytNbDRyVm9XYlg0K2UzdjAwald1S0tjeDBoZlo0SmFCaTRlM0UrVG5ZNUNl?=
 =?utf-8?B?THlwaXRMd2tSaEZ5Z0pKaThuUmVWYXBHRjdLRXVlaXlWZGlRNHRkNWxmVGU2?=
 =?utf-8?B?czZxbms0QnNDa0g3cGZVWmlpNGpaUkN1em80QkJYNG9tSjlnbGhQUkpRZGYz?=
 =?utf-8?B?OFpRUWptbXA0ODEzbVFxQmdLa2wzMERJdWhuMC9UNGxMZlVDTmV0UFFTMCtF?=
 =?utf-8?B?U3FWMmFXT1BianNHcm42KzBYejNyRGJVcTAxL0lla0ZzWHNPNFpUZHM1aFNX?=
 =?utf-8?B?VVllMVhVbXZuZ0VlUy8rYVRNQzBmbk81V0p5RWJGMG15OWw3dzZnS3hzQ2VB?=
 =?utf-8?B?REdZMUI4NjU2Ujhqc3pDVUxzSXJ6UTg4TkJRNlV4bzI4VGIrNThtTVBPamt0?=
 =?utf-8?B?SER2RGw5U2V1ZGN1alhTbG8ydXNvRTM3NzJLS2x6SGVXNElTZlpnZHNDU0Jj?=
 =?utf-8?B?Z1Evem9qbUpwaUovckVuL01LSXpoWG1ZcHNMU1ZzTkhUV3FJQXZ2VUpNR3ZU?=
 =?utf-8?B?cWx6TThPd29jbno1SmsxQnBKKzBWSWlYRUhNanNlcnU1MHluYnYra1l5eG01?=
 =?utf-8?B?TDU2cExsZWRabjFwOE4xcTd3VmdiSm05emt4MHh4aWhlQ3YxeW1BcmVIU2Nr?=
 =?utf-8?B?TVUvVUFsNGprSUhuSGRBRjBRT2l5VnpWTmZVdEtXbTZKWjNXMWVIWENWYXEv?=
 =?utf-8?B?dGZSOXRvdm9icmlReE1BaU0vTjNGdUsweGZLaDNHZXBSYmQ4WG8vNnVJZG5Z?=
 =?utf-8?B?UjExYW8zK1kvQU56VGg0R0dtMFNMK0g3NEkzcEFWd0VmL01MK2dISmJGS3oz?=
 =?utf-8?B?T0ppbUpPbVVLZjl1NlArTkRLWGJFRHNpaE8xd2Z4N1E0N0RLQ3FoekxvakRR?=
 =?utf-8?B?ZDBqNVNCcWM0NnM5bGVDOHRhWkEvWFRzd0E3NkNjaWxKUEE0bkpTdDlnYWtE?=
 =?utf-8?B?bWFrMTFhODlsWGRWbnRvbmI1QUk0NEkzWFFwRjVocnNKREtOQVUxZlRKQXJu?=
 =?utf-8?B?R3FBRzZlbi91Uk1jVXdoSEtHcHhMWnBOMHpRbWRPRlBaYWNiN1d0cm4zOE5s?=
 =?utf-8?B?cjdmQndKQ2Q1RUxHQVluS2NydVFqejJZbDdwVUtZcHFzc0VEL1Qvd3ZCMEhT?=
 =?utf-8?B?TUFaQ1h5QmVvQnBMeitUYWdjRkpDcE4xZDJhT1grejY5MHd3S2dlbGN0MGs5?=
 =?utf-8?B?VWYweWEzaGIyQlBGTVhHRU1hbVRpcytpNFpRUk5tUVFDUnl4bVVDS1VVVlQ4?=
 =?utf-8?B?Yk1KQXJxUm5FTzNxWnpXRFh2WngyUnp6RmhWL2d1cjVFbnBML3huQWlOT1B5?=
 =?utf-8?B?b3ZydVR4Y2JVZWVkbWZyV2NwcU1WeC9JbnVUa0N4V3hKQjdMcy9mc2tJL2FH?=
 =?utf-8?B?WFJIVnRQN3JyR3c5VmZNNXA5QVE1Q29BakRmbE1lR1hQTkNpc1RORDRIenhE?=
 =?utf-8?B?SWNXQU41M0tMQnVLQ2g2ZVBFaEF3cVoraGZ1aDBaTS9ONVZiY3dkUHl4bTg2?=
 =?utf-8?B?LzZ4NmpCRk5rTGNYM3ZuVDVEakZkenpmWHg3bkVBbHRaZ2RlWDRZK0pXNThy?=
 =?utf-8?B?SGtaWTRwNnNKRjY0SVk5Yit0R3dkRlJqL0FuVUpaOGMxWkd6Yjd6VUVOL2F1?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YJODVesInuUtr9rCzDSQFmk58fqMJTBcQjfdkzT/OhrJRd3WF4FZpSJA44MTPVvAJvZlPkHdKawbNuZh3nQydO9uJi38XHchIdH/IcEDuszKdZ59h5SxzjZLeOJA1hXKI2SzzHztCZRcNN6Pl3KsWFKylHjeaUXff0k+qhjXkx2O+mvlmCzWEBXO2amruyKWS5JJjghQy2B1LpdpK6HyOrVngigwX+0uamNxKo5G4gYYQebB9aT7rvvILOtNx/JfCm/2HOTBqa19VKkGNC5GkyIJMnx9SzKNCtiQuLzjepWcZEM48WLRsm7Um4R7R3be45OaQFSW7cyly3eSE5K20rxy/CH5g10nobnWLvzYdPLFz24OcjLKX+BmVj03c7Rsy3wqzU/7cJZjtIKc8L4SatXN9QaMI4XPxAPdD0SUSQK58xyQ5tnrWjnzeS34iTdGzSTIh+fuTHsWEeK3faO3cbA5gKGFmjBeyndz9YGKWqlxziWc+kluRsZy2/Uaw1spMjFwnnq9JPDdQW2JSSNcDktlapjW0DZCIl1NACMotJXmrg0H2WCTs/p/5ACGJQE810vwdJeYgI5dQrsL5BHudi0nOidFQYCBe5FSDaMW8NoCFfa6E/+IZDn/L36mSrJ8YJx58xPbR9YnX0zfBXiTXDF0QSA+QljmjysAg0EfblV2zbJVg4cAnGTvZLgCitp+ce1TWtC7QwoPrElorTjJwRnFlb1d3aPNr0JZ/hq0FPQC6K80IxfrCtm1+bC68HXg+J1WSpPtwasfXLwy5l67M2mdcCZNFyTjxSzcVFPX9m0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50f3c10-43f6-4196-df95-08db04fd9c2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 09:12:30.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nS9OYXZVeDw8jLV0IW2PYKN9FyuHCnGTmGmh2eFFuAa4Jdw6HNJzK/YOXUq3ATUz1dStBbghfrnqpeKNF3VSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_01,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020086
X-Proofpoint-GUID: KRowiIXDLkwT2yiS0czh_J7CFd3HsjGa
X-Proofpoint-ORIG-GUID: KRowiIXDLkwT2yiS0czh_J7CFd3HsjGa
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/2/23 14:47, Qu Wenruo wrote:
> 
> 
> On 2023/2/2 14:28, Anand Jain wrote:
>>
>>
>>> +    bioc = kzalloc(
>>>            /* The size of btrfs_io_context */
>>>           sizeof(struct btrfs_io_context) +
>>>           /* Plus the variable array for the stripes */
>>>           sizeof(struct btrfs_io_stripe) * (total_stripes) +
>>>           /* Plus the variable array for the tgt dev */
>>> -        sizeof(int) * (real_stripes) +
>>> +        sizeof(u16) * (real_stripes) +
>>>           /*
>>>            * Plus the raid_map, which includes both the tgt dev
>>>            * and the stripes.
>>
>> Why not order the various sizeof() in the same manner as in the struct 
>> btrfs_io_context?
> 
> Because the tgtdev_map would soon get completely removed in the next patch.
> 

Ah. Ok.

> Just to mention, I don't like the current way to allocate memory at all.
> 
> If there is more feedback, I can convert the allocation to the same way 
> as alloc_rbio() of raid56.c, AKA, use dedicated kcalloc() calls for 
> those arrays.

The alloc_rbio() method allocates each component independently, leading
to frequent memory allocation and freeing, which could impact 
performance in an IO context.

It may be goodidea to conduct a small experiment to assess any
performance penalties. If none are detected, then it should be ok.

Thx,


> 
> Thanks,
> Qu
> 
>>
>> Thx.
