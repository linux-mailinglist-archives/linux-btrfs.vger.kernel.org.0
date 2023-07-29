Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483B767C18
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jul 2023 06:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjG2EWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jul 2023 00:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2EWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jul 2023 00:22:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED85420C
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 21:22:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T3w5UG016122;
        Sat, 29 Jul 2023 04:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/+Oqubs5ft2hi+0DnEkNv/wGgTvn70fherUL2UOORvc=;
 b=ZrJe7ATrkoX2+MIu9Mgz8Z7CZSRU65//s2bXXwBMgot+dAVAeC6Fkz+puWttgQ1gQOys
 w5WDTK3p6uRTd2Viv/t07XE+Sino042uhd/IpI+CrFAUBanL+6pG0njXxq1Hp1u9Jzrf
 ktBTMF6WdOINVxss69pwTG6l3YTZW1eStubBHw837h+kzBvB4XtXoF6CwfG/D9IKzATu
 Y57jfGl/WlbXD9yP/0c1W1uVErk9ueplmoOV3vr7G32HXPXN1fdlm4EQXasMDi81TzQZ
 CJE6fk0RRVXcUT9pYbx32J7lxnRUiCahMyOquPyVQktjnPMulgdkgGQA7zBdd4n5dnLN Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uaur0h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 04:22:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36T1XkHe000697;
        Sat, 29 Jul 2023 04:22:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s77urc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 04:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF5g6Tth5vJHqgWLCGFqY6xpuvHg3tSVvsMXL7wmt34E/EtoyeFH4eSjB+jb+KD1vV2LVTq43O64O7gaOZ0FOmP5f5bUXzvBb8tzPftvMXOdOZWTM2UH6tDrlDAaWifGzR+GewRCa04GxlvjX4M+gGISY0nmWl+J+ACACh7hX9VjVVi8MbqQs2jk6l7WFDoxRJavDGFj5Qu4admLuyYWViZBh6H/9K9bOm+9OkGqWwgQ5MsH3WKFQ7GOrWWeY3azuE28DxTb6VJAwPRSeFUydZdVPMoqbISovt6b2G/0aYgkIaLaO0xcHMgutkrZQowVzwJTb0Mz7SR8iuGh+uDYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+Oqubs5ft2hi+0DnEkNv/wGgTvn70fherUL2UOORvc=;
 b=ZBan5MPxAIiOwwnBduQkdKYlwlzuGksvkMRW8pS1c1sIf5zWu6G0o2VOcr7Vno2+k6wYU9Gh9PAeAYodYokdoOE11/VxNBFIc9DXnHpBA+b7KjHaWR2TIqEfZz2aTUxLJi/DNabUmKMM3L+MjW5QElakdhZVbwbcYMsVNSjwjTJeJMvWr8qn/vFzIIQKHantc8AXycBlHm9RMzag+PP0Od/T72Cde7TXSKPurM+k4cuPcbW+uA3wJApErPoHHJcvv5c+79Dx0HmCmNB+lRuH8AJYE+TDVAa7CrksbfnRj9GqcC9WoGinNAd41ULYhgXq8giXsG1NH5Rb8d74/Q5moQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+Oqubs5ft2hi+0DnEkNv/wGgTvn70fherUL2UOORvc=;
 b=kmYAgPeRuE+cayJaIkIsKQbvz7TsSmgv8phx1h3zPwDzXdmRdzF5Cw0VibGiOIEmRnYWBrs4fqWTTOFsRDki5jJYlmM25om9ztY9fP+iGebxlccrNpo1ATSIvRqLHjRCK72/5y85VQjZGk6y1VFvsm4czBDN2ANq9xMkWg45XuY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 04:22:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 04:22:27 +0000
Message-ID: <a5fa2ab6-f72c-5f53-10d6-f08fc78198f6@oracle.com>
Date:   Sat, 29 Jul 2023 12:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or
 fsid.
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690541079.git.anand.jain@oracle.com>
 <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
 <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
 <20230728183907.GK17922@twin.jikos.cz>
 <8507d459-ecbd-b123-d8ae-233d2efa3ccc@oracle.com>
Content-Language: en-US
In-Reply-To: <8507d459-ecbd-b123-d8ae-233d2efa3ccc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 69499326-7257-44bf-f28a-08db8feb6a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i66Knk0lnEzDlaMqpM/5yNRyqPP0VZVcmkmLNw5rsOFrySEHXBa+lbkfk2kY2MY7tNQEv+Zpjfw8u5IFzRjUddyIO+Grj61oKvRHsejBF2piUQwDj+RIRVIK4iobaVGzdOInhzGHQgXnxh9qE64U8TFjKcJjIAmJWIX3Y0DR7IlcQZ7De/oRwUUIvkPlK+5+SpCFckDL8UuuIpYek0XuM0KLIIfdyfRs/hGOjU/HN6+Q3Iy8NdsFAg4++nvF01IbMnQ9uvSZbsdr7KWSx5pnffHAT/S/fHN549+SY1BW+YuJpnXQSxSA4VXEn8ocMxR+P+sZp6ZTjOT0YOxR2ND7i8LtZvu8q0lWrxLTN7eXggy7VI4xDdKr4E0NgSuenE882oOmhaa2PTXwO2sOgZBe1L6lGPjQx6uDwSCbPzp1rVX15/2Vi+jA3zQQjpCU+nOP0/OhJtDB5zrcWFXFnLys9KCgeTb3OZFfZ5X9fIKQRf4mrA7UlLaqAohZGKua4vCYqT5WP5MLJ2Em2n5xruSKRZZ0oZbT0LMQ2BldNv9tsksYTjsEmcY0OraLWLUJeatjaGCxw89mNppvbtUuqMSkDgAyas37Pn1g4XtAkR8JhBpWsQ4xhVZuizTrgZbpMliZ/7IskN8KXNDb9P+VMnEP2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(6666004)(478600001)(6486002)(83380400001)(53546011)(6506007)(26005)(6512007)(66476007)(66946007)(66556008)(38100700002)(6916009)(186003)(4326008)(31686004)(2616005)(5660300002)(86362001)(44832011)(41300700001)(316002)(2906002)(8676002)(8936002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2QyaFhqWjFiZnBxR0RwQUEyaEloYldycDJPcEgrbFo4MFYrMVZ1YllBQ0hF?=
 =?utf-8?B?cnNWS1RPOGNwUWpUSk84ZUFsN0NwVG1xdzNaZ1pOaEVhakRpYVVvWUpHMCtU?=
 =?utf-8?B?WnlRc0Iyd0I2WkRXY2N5aEFqNWFISW1ObndJKytpVlJleitPMmlPeHkxSFc3?=
 =?utf-8?B?Q0FLUFlaRlZ0ZjRYZmhheUMwM2ZNNVpMczZtZUJxSXNJWG15Z1N6RjQ0VklI?=
 =?utf-8?B?Wi8rZ0Q1anFMMGRrTzdMNndnUExNWVlkcmM0UkNBRHU4OEZYR1RVd1EzaDBm?=
 =?utf-8?B?VVk4bjdUaXkzWS9oVTlsT0c5WXNFR09WWS9aczJFeTk3YWhTWWt3Y3JIbHBJ?=
 =?utf-8?B?QkZabXFST2lsTkxGS2JyTXRyOTZidi8zVmphdUYyK2JVellUUndCZGZDWG5t?=
 =?utf-8?B?alNpMzNjVHBWb2RzZTMzaTExSEtXTDRheWgvWC8vcTdTb3NUYWxTTGNXWi9S?=
 =?utf-8?B?cFJOV3RKS1FVemFyRy9mMnRvUU9uK0FMcGFWelVkN1ZQTzZIYzcyY2czbXl0?=
 =?utf-8?B?eFp5dHh4NGpmQnRpcWhOVEM3bmFNRGNORXhmVllWWEc3b3JrazhqY0VYT3VK?=
 =?utf-8?B?QVRveE90eHpvdzVuK3A2OWtuRXhscFk0QWNZbHpJanBON1N4aVhKUEtBa0lS?=
 =?utf-8?B?N1pwcGtmSGxkWXhWU2VMTVk4dkdpaDlDVWhMemkrTzJqU0RCb1UxejJoUTQ3?=
 =?utf-8?B?a2hTSzBPZWtQajZ1V2grMEZDWUJmejVlSWtjNUUxUFgrLzVRaFVjNHgxd0Fr?=
 =?utf-8?B?QUNPWEVOKzNrcVN1dEVMZVZjVFFBNVVKQTdWcWtVWXZ1ZnFTKzJCaTl5NGJN?=
 =?utf-8?B?b3NuSmhYOE1rU3JNWFc4MVlwUVFtbFgwZytTTzg0YXJIN3FrVFRCNms4QlFV?=
 =?utf-8?B?djUzZ3plcmVnRWdySU9lRFR6T011ekFIRWZrUTFtUW9pTVRwWmhlSCtrZVBy?=
 =?utf-8?B?Um5ZZU04Q2VhazRJL0hrQ08xWXlKZVhyeHJxS1BINzBqalFON3dFOHpNRnlm?=
 =?utf-8?B?QmRwSHBqRktCR2FHSmxHMUZ6SksyY3FxWFFyYVBXNFkwTGEwRG5OUVJkRjlI?=
 =?utf-8?B?alhFVVZoTTJ5K1JBMEFYVjNKS2NsRnFLTG10b1k4bS9QeVV0bS9qdnFnL1Fr?=
 =?utf-8?B?VDZNWEszLzV0QldtOGI3Q3NEU0phampZNUF0SlUvUmRPWmQvYThKa2NsVGVI?=
 =?utf-8?B?K0xFTjdUR2FTN3hzVmJTZGVCdnFvOFFsSDhKQkYyeWpPR2p1TkJpT3ZDcGdz?=
 =?utf-8?B?VG9WMXFDZXZkT3lzeUMrRGhFM0Q1YlVnYTRMdGtGelBzR05HTE51dGs1NmRG?=
 =?utf-8?B?Q3R4Nml2MFY0RnI0bTNSUm8xNVM3ZW9xUHVvYXc5SnNpN1R1OFN4RmlpS3RV?=
 =?utf-8?B?UlBFdHB1Skl3eDE5K084aVVBRTJwQ2hYMGFSY1k1c2tYMW9KajV6V3I2Yitq?=
 =?utf-8?B?WkpoLzNIUzY4cEltVmxRWktiSDQzSWxYdVBsKzJRY2J5a2lkaVRxdmpTY1dW?=
 =?utf-8?B?VUxWWXdIMVppejVVSlFkaHgwczYrWE9XZG9lTXA4dlZkb2xmRTNxcENnMFYz?=
 =?utf-8?B?TTV0SG9ybWhueW9rRm81TVpMQjJSbzl4a2gzMDBTSUtSWUFUKytFUjJOTDVD?=
 =?utf-8?B?MFhObzg2SmNXVFN2dGphMFY0QWIvWXBQMXk2czNLRGp5MEpDSk01THR1Sjkr?=
 =?utf-8?B?a1ZlRTRvdE9XekI4Q2JaVlJQVVFJcVZUTlRUZHZYYThWZ0o0aDhyWkFGL1Zw?=
 =?utf-8?B?b01makY1TXJLWE5BQWVKWkZ6TS8rTEhmeU5Db3dMTkRBckp6RlhzZFY2OGhV?=
 =?utf-8?B?TmtnaFdkdEJtRVg1TkdEYUtsSkpyQnBadXhqVVR1U2tMSUdabDUvaXBQejZB?=
 =?utf-8?B?RWlVQXhUU1hCb0JjQml4dFFjanRnN3U3NDFGSk14ZEhoa0E4eVltRmtXQVhB?=
 =?utf-8?B?a2NkVk9wdEFTY09HV2d2ZVVHT3hUeEc5Z3U1ODNOQVVuM1Rac2ZWd205UTJR?=
 =?utf-8?B?M2ZxSkdzQ2xuOEYwb1VhUUZoSWR1R3RWQmNSV2lXbk9EUWpEcWRHT3g4N1lY?=
 =?utf-8?B?SFV2a3gwZmxzOHRvQVZaYityUHVIMkIwT2hhMFJnVWhoeHpIMDBQZHhObHJt?=
 =?utf-8?Q?QF2z2iU5ITfGPOgSTzqGmxWBb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7AVm4F/IYfxTFySARNSdTSts8bNhKnaBHQdu4EPY8I5dxspEsi/NIy3dQH21isXtbmJO012QUSjJ+s54GDTA4GZLxVakt6e8jelUDHd1bkte1S5Nx2CRxoKmJKT8LY2g3F9yJ2LUeIJFcxP8xRcZ1FOwGMfEdUpVvEZUSec3mQfNUeUXbvYBsKmipZBSs3nRhNAUu0xR3bEFfpx9zIgHzUrV6GeFcCWzV9nymQEEGey7KloytOc1HCPm3esJzVkgcx0B2nnleYnFu/D63+aImfIcsNm9LkdNcrXOcXJdHXZnLkRll/9iS0MX0nU0PQkKwkzREnrdAR7+GIF+PTXx73GH3Im9QTcis/qIkQ6yl9A/mNo8l59o7ma+AB8xqLRLEFOPdTNsg5e6IlcqFsMc/O8vnXJDqJNe2G5gWgSK2VB2YFVO91QJEY9nwIbYSgVyAL5FnyMIfgsjlviZgVKAiBQ2EzAUnM/NSoTOCB0BNlPBhzjBOzulxQsz221ZtqFGzZOltJdWArgi6q4YAOUvM+xMi6dg+jO956JMzI+EP5LfetXFV6NzAD9WOrunICjKlYc2TLUNS1mhxKCbPRSp7TQcYDxr8/mEZIlBztEUMQMmhsNhkfdKuZ32P9BzLTXuf8EYyKP1o6H2/7jfhSirEIBJH3nIfc6/EoGOVSD91Z1HA0HUBZY1usQ9nZUeCrQjYIF+eEGUaiN9PDXz8IKyx1/mjwdKziW+ruhVDeeVyCYmF3FH35kq+H3vYqldLXLtQTmk5Os1AduunisFTBGK4zR637NpDlD+HRDRw6zA/0+MLu2NKjDkzCnMuwZPFIIJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69499326-7257-44bf-f28a-08db8feb6a69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 04:22:27.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUXHcO84Ma+xw8AxwkILDaS0AczMuw0E5itxkwFltDicVnvdZQgMla9Us4fkf3oFpr0/Y2d0qnn3as+pbu5wGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290039
X-Proofpoint-ORIG-GUID: c1IXgnF-8lGKDruE-glrUF2eiLpYuR-f
X-Proofpoint-GUID: c1IXgnF-8lGKDruE-glrUF2eiLpYuR-f
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2023 06:23, Anand Jain wrote:
> 
> 
> On 29/07/2023 02:39, David Sterba wrote:
>> On Fri, Jul 28, 2023 at 06:40:39PM +0100, Filipe Manana wrote:
>>> On Fri, Jul 28, 2023 at 5:43 PM Anand Jain <anand.jain@oracle.com> 
>>> wrote:
>>>>
>>>> This change makes the code more readable.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>   fs/btrfs/volumes.c | 12 ++++--------
>>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 5678ca9b6281..4ce6c63ab868 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -833,14 +833,10 @@ static noinline struct btrfs_device 
>>>> *device_list_add(const char *path,
>>>>                      found_transid > fs_devices->latest_generation) {
>>>>                          memcpy(fs_devices->fsid, disk_super->fsid,
>>>>                                          BTRFS_FSID_SIZE);
>>>> -
>>>> -                       if (has_metadata_uuid)
>>>> -                               memcpy(fs_devices->metadata_uuid,
>>>> -                                      disk_super->metadata_uuid,
>>>> -                                      BTRFS_FSID_SIZE);
>>>> -                       else
>>>> -                               memcpy(fs_devices->metadata_uuid,
>>>> -                                      disk_super->fsid, 
>>>> BTRFS_FSID_SIZE);
>>>> +                       memcpy(fs_devices->metadata_uuid,
>>>> +                              has_metadata_uuid ?
>>>> +                               disk_super->metadata_uuid : 
>>>> disk_super->fsid,
>>>> +                              BTRFS_FSID_SIZE);
>>>
>>> While there's less lines of code, I don't find having a long ternary
>>> operation in the middle of a function call, split in two lines, more
>>> readable than the existing if-else statement, quite the contrary.
>>
>> Agreed, one line of code doing one thing is readable.
> 
> My POV was one memcpy() per destination argument makes it better
> summarized at the function level. Anyway, I am okay with dropping
> this patch.
>

I missed something. I have a helper function btrfs_sb_fsid_ptr() in the
patch 3/4 which reads either metadata_uuid or fsid as per METADATA_UUID
flag. Which in that case the code shall be

memcpy(fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(disk_super),
	BTRFS_FSID_SIZE);

I think this is better?

> Thanks.

