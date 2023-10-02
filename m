Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67A7B5D3C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 00:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjJBWl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJBWl4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 18:41:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6051B91
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 15:41:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392KdJ82027937;
        Mon, 2 Oct 2023 22:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vdms49xQn2pOKAe0tFBCYobty+wfRBT97kQw573i5qw=;
 b=3G8S2y/1WsfNiF8jMXluOMoYfVxNyiXK4j3ThTZb8neJGnAodcE8AwuzG4x9oA5MTKo3
 hIQD1H1vjGn8UsNKUB8kitDau/tGC0KPO0CnIoGoTSDaXdEnQLILyqqouMxk7aEZ4S9v
 Af6HBwlVGaJbcoi0PclJ1sOBjBTrVwANysWp8EisWpBSWnxKKBwyM/YhmPuzRcF4AYd5
 rIElY/w37rKOMDlLtZ1cw1Smxz5bcxvLZYSfZXuns7ySlaGvzGebNEOv79NMxMKFZzwW
 i1gvruceeSpSyOmGzsijpeLpMZA4ooDFsMi5yJ25MyZE9Cs8KBmrNbU9cU3MB/p5l4RL 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbugdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 22:41:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392KUfZC002947;
        Mon, 2 Oct 2023 22:41:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea454va1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 22:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk81mS3H81CePKdriNMsrDBWF/0q2+tzbwUrzh+SGN/wyl/qT7ZZI7cZoLW6sHOeHHV269FMnG8Fwizg2qheEId4O05KOu838Yd8Nf95jmWOYMqxzHgJzHTMicUuVPjUbtyuYwOFMM4Kr41z+yQrHMuOxMPDNeZTT9ktHpPm/HFP+SzpZZv2jrxfzO+zlaCtuUptbJc7bY3wSvtIxQzcW8HPfwWKTK9MAonTCCYzxaB2GjPX/HwqXYy3fwTec2DDiQjhbMcHLHsFvkjUetrgBsaBHzn3P/QULqQq89IRgiffYvpkA8dKorSFMhUlYoUBPskD7kRTUj8Vv+lTH2GwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdms49xQn2pOKAe0tFBCYobty+wfRBT97kQw573i5qw=;
 b=lm0jlhHwIGBzqxoXwSZOGSBy2LlqDxQza0cCSQDPOfazpTTMghd76TAfTzCqN+OJTZw3ADl8UG8Q+zc0/fdhEXWjlBXomRu3quKF0CFYCNDGVL6JAvcZdf38vexR2LHV+8+vq8G3UqyZ1c52VB1/qSOdttgmkNnlm6npL1WKeZHZlzzqF1gpbXUr9RyKMDoJ4ApLSTsdzfKCQNnL0NhoFgxkraTzpm3F15+FHDydHBV4kf3+fBEYzkwOeOfyuaHEcsc5vWvj+mdbkbd/hJpbVAEULuiXLJn3Y77+WtJkq9Uh7X8or6zQ76z01nV47se4Nr0VprupzaeU2xSrR9OQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdms49xQn2pOKAe0tFBCYobty+wfRBT97kQw573i5qw=;
 b=M4UY28sBh6DXLQUhVUVeL0Wn6SSiPZfVy7MPzJtCrcNBi3FffyovFquHYeVoFS4TSbatvIraHMV8bMJ9bb+/N5kvVLrbjQ4xKRq+ex+fdQooDRtSSmAZiKsInvJYhxwN0LrgyYoqa8kY85vqRNpN0d6lncSSkK3NDweWuNiOwWM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 22:41:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 22:41:36 +0000
Message-ID: <7dc8e662-ae00-498f-d42d-93727f811417@oracle.com>
Date:   Tue, 3 Oct 2023 06:41:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <cover.1695826320.git.anand.jain@oracle.com>
 <e85f357bfbcef98bba37e2f39e884a371fc25b56.1695826320.git.anand.jain@oracle.com>
 <20231002125739.GN13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002125739.GN13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8fb89c-be5d-4b61-e9dd-08dbc398bc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NCb38ZkDPCqIiixapkU/TxRSaGXnGrgj9Kvz66J2+9wP/Jvk/B3Tgja+Ej6f9hXfO+hNg7qK4cp3ks6I+eVHYI6Xbjs9DrhCG3LEqWB2ruBK8l6cwF+H6lRcqT23JTX8Nv3d9JB76WMqbvErP/7xDF5uTuhUoN7Ie4r0zXJ2vL/2DVKq7dm2ecUFu2EJcyBGgBCyvIscIbt8UjmlZ4KQQH3RklIW/F6iPvRFIorIlDJVshHTy2YkBhRFSsWdjEBwPrfjcT/1dqT/9c2Um7jwuawvBkinIc02R8zyyDTIEpSbmQneFJn1Tro+KoYJ6rxH0ZSy7wBmv8z9bPPSRFyXK98m+1v4Xp0njbNdhpzYCdFyASAyg3zp9Nj2MPH/rgPl7F3YOq+Isosvfv5sLQsXIy1MKftLJ3dW7L3vNmLbiM6ialx+9EDqDcDLSWdbsJGA9JYHq9M/mP8/Lep3O/QxSfr41MLz+EQgZnEfNuc84TBimo4pJlF/YobXBbXK5fTynhfX1sCm+MkNxT4DpEkEVB9cqh771WgApMsiuy/U2pu3Oztydk9GrRMSwLxFZVNcdAk/QQHygJT285XU0VuO1XaV39i3xiWmV8OQLfA1DYy/H/D/nmu6JF1vWFK0H29UJiFrNWRJQa+eVWBusn0Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6916009)(316002)(5660300002)(66946007)(66556008)(44832011)(66476007)(6666004)(966005)(4326008)(8676002)(8936002)(26005)(478600001)(6486002)(6512007)(6506007)(31686004)(2906002)(53546011)(2616005)(83380400001)(41300700001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVAyUTJVTzhzYU1XYnU3T3IzSkJRMEYzdVpBQ2JWWGpKTnlDc2gzZjRUK2xo?=
 =?utf-8?B?UE05NjhvNWtFeDNINzVla21KdEtEVWZ4YjQrak9Cbkkrd1A4N1AxZUpFR0V3?=
 =?utf-8?B?M3ZkaStpdm5tZFBJMDNyWXJZRzI5U0JIdlB4RXZjNHRXdGRvNUxBWmpnSVFL?=
 =?utf-8?B?akxNczlGUVJmMlZORTk3VmRLZnA5akZ0U0JpcjYyd2ZIMlUrTHhaSXNyTVIr?=
 =?utf-8?B?Uit2KzczWXg0Z3ZmdVEzaVZZQmRhMXpQYXpta1A3RTVDSzEyRkhZYUlwNEh2?=
 =?utf-8?B?Z1FBRTZZYXJmbmFhZ3FOWmZXUUN2TE9MMDFTZm1TRTdCalk3QUNEWi9jNWpY?=
 =?utf-8?B?ditlSUw4VFdYNFFjSWkrZGZEVmdsMTNKTExLQUhyb0pvQ09nTjBGS21aOWtD?=
 =?utf-8?B?bHdvdkpnNGx6TFNwQ3NMMXhFQ1VuRy9ncWo3WWh0Y25UMkhyTkdZQ2VXM2Rx?=
 =?utf-8?B?L1NtcU4xQ2hxdlMwRkswZXJ1S29iQnVmbUUrM1lJMkx3WFBGY1Z5SGM5L0Zo?=
 =?utf-8?B?REhWc1oxOWM5WUUxVXFXV0JJTE1NQm9CckpNS3lBeXVZbmkxL3EzT3ZTSktS?=
 =?utf-8?B?ZmpkM3Y0WldqeElyc0w1UTBIYWNQNW80UHMrT0cxMDFRdUlZdUp5RStpUkpI?=
 =?utf-8?B?NmQrMEdKNFV4eGwvQ0hOV3cybURmNnZKdExIaHBDaG82ZFkxbmlRZnBSRmpR?=
 =?utf-8?B?QXhNTDB0akJWSE02T0VRTHRNblBXck5ucXJ1SnF4cVVuVDdSckMvVWlmZXY5?=
 =?utf-8?B?UGEvSE1lL3ViRTFKWG1LTDdLQy9kL1NaUkFqeERqbThmUXZGN1NJcTF4NVVl?=
 =?utf-8?B?NDZCQVIva3VjbnYrZkZHMnVPSndyZG5aRXY2a3hkUG5KaFQ4dW1QYlljTHJz?=
 =?utf-8?B?czNuSjdmRThCY3Jnc1pGbEdwb1RzR3F2T1RHT3hhRVo2YjV3SStSZkhabkdp?=
 =?utf-8?B?UmluYVRkeEQyVVdzeTA5WTNtYUVvTmhxYSt3YkpMOEt2dUx4cTczOGRSUWdG?=
 =?utf-8?B?em8wcHRGTkNHUUxOdGlNTG95TXFrc2p6R1RHdUphUGFJbG1BNjlmeUMyKzc5?=
 =?utf-8?B?ZUZ4ZU5zalVjbG90WXF3QVIxT0ZhVkV6WUlSMjVVLy9lZ09QdzMzbGp6N2Iw?=
 =?utf-8?B?NlE3eExzaEtDazJCUDA1eUlIbnBCNkd4TTVNVWhQUDRSNCtSZlF6dHZETDVn?=
 =?utf-8?B?ZFdPL2xHYk9aOEQyejUrVkl2ZUJBMVVsdHYyUlRtL25lRU1BLzlRRDV3NHRr?=
 =?utf-8?B?YUY1cFkvNGZINU9kSlAvajlTRStwa2tib1g3K0l1L1NrM3pQUWRBTEg2Wnhp?=
 =?utf-8?B?QkJSdlVCNW1DbVVIQmhnUXAxb2s4aFVWRTErOGt4WnNKT2NJaE5SeDlnQ01K?=
 =?utf-8?B?OFBKWUs4cGorWXFmZXBSRzJZbGdRVzBGMTJvSmoyZ3JsTkQxalYzQ0RCTDBt?=
 =?utf-8?B?aFlFRU52K1JubEpTT1ZlcUd2ZTIwb0oxZjRIdUE5enNPYjVOYm9SVm0zY1h4?=
 =?utf-8?B?MkVSNHRiOFI0RnF1MHV2SWZKNjNJTUtGcjg4TGZyR0RPVFNQTmE0MmxtWm5V?=
 =?utf-8?B?aFJ5R2lxUm4xU3VJNThCK3JXVnpqSno3REJpYUVqdFczdUNQNDRMa0FQMnpp?=
 =?utf-8?B?Tzd0NWQzMG1wNHl3eXFVVmFlQ0g5ek9uejRQcldXM3E0cFRra1FZTE9VU1ly?=
 =?utf-8?B?ODRQY21XS1Jvb1ZwVFRSeW1ESjlaZkxHY2lFbDhrQXhVTDJIa1VPYy9sMHUy?=
 =?utf-8?B?ak50NjNiTC81THBCemhsay9qZVo3TGpSUVovaFZMT0FRSVRSaFA4dnhPemp5?=
 =?utf-8?B?N0UzUHloaEtxM3ZNTm96UnFyN0dWeG51eVZDazhYbmhxSGEwd08za3U1V2g0?=
 =?utf-8?B?RUlKeXVHTENQbkVnWjZTNE40ZTZSV0ZyaDVCN3hOdXdCa2lraTNnMVo0UnJ1?=
 =?utf-8?B?UGdRSFZxdHpQcVM3QXFiNVBtL1F2VEppdDU5cnlTVWdydHpYYXRQWXdtNVU3?=
 =?utf-8?B?cVIxdzZnQU5lN2pnS2prZytoYVdURlI2NHlLZEVZTFlJN2tPVVFUajdmL0t2?=
 =?utf-8?B?V0lOdnBibGVtNjNHTDNiQXJ1T1kyU3dwRWNob0N0WUozTThMQjF4UTJuOWph?=
 =?utf-8?Q?xIc9r4liJ/s6yUI9FVTZZBhC7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2s8WFE4PpslFTVJd0kE7BDK+MYee1bP/ZgXOlMhQmWjbl1BOZ1CxsXcauXXgIRDegzCl5f/3zmvJNr6ZTQJ9Uhel7/sICAImizJgoPkZ09c2xOLuYFCEV3TO3/B6j0jAw4ZGJeibmO1l/D2B7whVdhTVbPEInjD3UvQaepckFS6NbOC/GgZ4CKBLHPI9+wWIJEd1j4Cr6QGnAcQFV0SBsgrrsB0r/2EYLRwh7T/k3gmvxmB3E0y8xJaZ6jY3j5YH86FyS5paZDh1+OvtWj2muY6vdLlxYtyERb7QryxBflNQgBpZu6CFiOF0MHKv/MYS8gVdqiN497On5MEDcgZIMYoMW8yfLqjmdOob/QEyxPzbRp85MpYzLWv9siYPal8/qBsKd/Ra0Dkp2LJ+HutRBArdOfXaGMNZL/385UqZ4bJYjSVlxUDMg+rseHpuU417pui3EQKFtuJak0/2lFys7Wg/3lD50kGybnC93Zl2G4o3KeelWJY8UEHsxtPwEO/Bf1tjYP39XIMg3z8i4JCzDIYzW1eT7bciHbNQi+e0B1/r94GfvpgvHlgWdfDMPiivRCsJSWz0V5IlyxL9O3HD9zo5Qoqn1eVGWmPxwZVqsd+AE5BuLui3yd8JeP2HuhMsAhcPaPH+8NSEYo7JNxHdQBUOAH4wK0KzFYmtn1pYFz10dgSP48pvqeLmW8PT3bEAb6SCffBn6vJXZ8JQ1fxE+sUuNKHW6AgRAZlyB6R8a3SCWVO9aoFF709mFtv7ctVOUHdP8hxeu923hg8usrP7ucQd3YpAmX8CkttOrXvkwvuneoHR4MsxfttCzNPwCAYf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8fb89c-be5d-4b61-e9dd-08dbc398bc10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 22:41:36.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBdZM7KvnE4uCYMvQ/kMPrbN8Y/s6G4HF96XXkKFjP7GJPn4UtbzrZoK8gAWGMpfb7WIhJoGSAPAIdHiAV3SOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020176
X-Proofpoint-GUID: tNff_uRAsvImcFPNeEjVVm5nA6PwdiG9
X-Proofpoint-ORIG-GUID: tNff_uRAsvImcFPNeEjVVm5nA6PwdiG9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02/10/2023 20:57, David Sterba wrote:
> On Thu, Sep 28, 2023 at 09:09:47AM +0800, Anand Jain wrote:
>> Guilherme's previous work [1] aimed at the mounting of cloned devices
>> using a superblock flag SINGLE_DEV during mkfs.

>>   [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/

The link should go at SOB with prefix Link:.

>>
>> Building upon this work, here is in memory only approach. As it mounts
>> we determine if the same fsid is already mounted if then we generate a
>> random temp fsid which shall be used the mount, in memory only not
>> written to the disk. We distinguish devices by devt.
>>
>> Example:
>>    $ fallocate -l 300m ./disk1.img :0
>>    $ mkfs.btrfs -f ./disk1.img :0
>>    $ cp ./disk1.img ./disk2.img :0
>>    $ cp ./disk1.img ./disk3.img :0
>>    $ mount -o loop ./disk1.img /btrfs :0
>>    $ mount -o ./disk2.img /btrfs1 :0
>>    $ mount -o ./disk3.img /btrfs2 :0
> 
> I'm confused what the ":0" are supposed to mean, is it some artifact of
> your editor?

Oh, sorry for the confusion. It is the return status of the command.
I have some local scripts to collect the output. Could you pls remove 
":0", or I'll if there is a reroll.

Thanks, Anand

> 
>>
>>    $ btrfs fi show -m :0
>>    Label: none  uuid: 4a212b48-1bec-46a5-938a-783c8c1f0b02
>> 	Total devices 1 FS bytes used 144.00KiB
>> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop0
>>
>>    Label: none  uuid: adabf2fe-5515-4ad0-95b4-7b1609218c16
>> 	Total devices 1 FS bytes used 144.00KiB
>> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop1
>>
>>    Label: none  uuid: 1d77d0df-7d92-439e-adbd-20b9b86fdedb
>> 	Total devices 1 FS bytes used 144.00KiB
>> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop2
>>
>> Co-developed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
