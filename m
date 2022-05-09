Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DC51F2A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 04:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiEIC1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 22:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiEIC0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 22:26:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5B427FF
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 19:22:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248EChi3022574;
        Mon, 9 May 2022 02:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T88X3R9TYmStBmoSCWTJ1kI38hW7q7RQ69iqXEErAAE=;
 b=dSPwSdQJDP+Q2WmFKpltJpcbOSuZxxKiXAttZOcZ4aQA83QINhKBZznAO3ZFMNUY6g4f
 zzKGD2SWr1kLLv5EyfF8kAjxfNwBzHQsWqR83N5qDVKb9x3WMql4cpNDcyUScM+m5zhQ
 Ot/Gg/5+kPWf9vLfgsz2h0eexDL5oDm8Ws8YTAGlkibDXXAra1xex7johNwq1m943C9F
 BEc/R29LX7VmmJDuRW8Q63XbnkARFWdImeuG4h8J+PrlhT3z7fOvPtCGaUbsjugWhNiD
 s/ZnuO0BfxUKxtlzztbyMrRcNcdzptB0wCFBDldraqnF+wV7dIYG5KiWautgcAfSRIf/ iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhata0r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 02:22:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2492BDqu034660;
        Mon, 9 May 2022 02:22:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf70dxhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 02:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoedDAd+sHiuH8tzBNbbC9aWmf/2nHD+1F6Sc8yTYYSBKqZqt+3x/feVcKyCUGW/TrE30+EvPt49tF+3BnBo3HTZH43iuWX0zQ/TSoKDzMVmKs8gG1f7zZL40tD3OzWjSXzMsXGIHU894t8zzBxleMRF2/bm8Bv1s3y6kZ0Osun5OO4Xfa+RPVV1dhjfXaJUM6UFGLG15PfDCs8wjdx82UmEycN+TRcb1VKch/jrsivjr48LHPv5h5R/mYH8NVnXyISDBa0CweGJUtxvV37L0u0uvemxfxDEOxnFMY5HFtFUtPZRqMjhIhFVInamc9yirwdHkbF9PLXfDieYNlvVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T88X3R9TYmStBmoSCWTJ1kI38hW7q7RQ69iqXEErAAE=;
 b=YczQAJSrDbddaFiptXd6+mj1ZMIlDSxJPbPUuVgp1THUAwpy1LMVVlqk8+rfQj2tRxrQZFLyF42YCL8w995E5S3/m0qNPE369lruz3hyn0x1BCwDtBNu8E5U47q4YpB9NXRT0NUL1AcNkJoQ0N6RlAKa2W1yqccBvJfPpKfahdscssfbnbNtQvg6+knc+RFuLsEbyN3r7F8jZUKA4teVjUm+KRoveIJeGskKDoKjv5pmUyQiGNPUPyR/cs9cPSbgdsSpB4fCN3STHcWVLtakz3f4ujyCrwDGSWhOepc9qLxWAZApVaLiRTZFSnHFGUu8O9R9ibjYPO2iKFEbSB0JFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T88X3R9TYmStBmoSCWTJ1kI38hW7q7RQ69iqXEErAAE=;
 b=yCPq55Jb1GMBrZ16iy0iXSv8D+yNoKOf6t+qAtc8e61+zIc5oxi9HkG8n7g84UFxCpHYK3eATvaU2Fl+TvQNlz8Tyi8urto7w7yrqVCPh7zY2ev4vzfc765YEyYfgv0czwBLS8Z7FNeqrzRGIMw/LJORJJoyEyGm9LinXL+TkJY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 02:22:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 02:22:41 +0000
Message-ID: <f1800309-043e-5cbd-b438-3e1258ed9c61@oracle.com>
Date:   Mon, 9 May 2022 07:52:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular
 extents
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
 <981a54b2-884e-0426-22e7-f8a332d7b331@oracle.com>
 <a9cc3342-9658-5f5c-c26b-80a3c7bc9ee8@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a9cc3342-9658-5f5c-c26b-80a3c7bc9ee8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54135113-3d22-41d0-7447-08da3162cb47
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4415:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44151D628A2103A4BAB225CAE5C69@SJ0PR10MB4415.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hw5RYLpf2AY189TD8W2WoKVshtWS/1Z9cJP36Ml4vshiPgN2I57W8/YStPULHnT0aCMcDuTwRnGhOvfI8mxDeu0j8B6VpojT70Zv6/q4ADR2FSED+mZZS7RFGYOt05wyTnAQwIsogLDuQrmtYj5C2fM6jqMp6bm3KXwGPCRHbyqN2+bnR6h3GhuVkAq6BNE/2QQmuy3VtNAq/43qB7kAKrsXXJ/kYYr4S3clLCtXVc4kQE5XhP6B+WJglh7HB15K9XQM9m7VZGwPwMA+Zq6V17TBLeNvuPqgSlnh2zH13mWfhegbEXbhwgufsGcZhPhWSWljegeJUjl0P+rD1XLRM5gkhfBljnpUZwp9hIwSh8OZtJyuicbxV1VrTyC5jn3tggYo1E69b4+c9jKD0oWJX+B0tL+n7h93CBBWI0Q6DWZvbD65UquVFKWNxiK6ksHP07y2pmLmcph3D586+Q8bQ7A2utfTL9kjPvc8BMWCB6yyBKGc4p6P/saEXerv9ONEExEIRCWNvV0GRh2nC5iispBbMbqJbevEkYrnuCepXTn687lq+NlJs8rGcLYx8BE7nsSZr3Y/vmCX3G01pBJ6HexjNsPp16zhnvTYvemH9Xs6GNoeZpkZZ+Zfik5/rW8mBBRuAAjYRfN6SARLHzQM3V2yZZJLnMBQzTbdWGej5ROlPqwuOzjZ1YEUsRPP7s9yD2N2ymaaYRplBl3d684axrrO/mJM+l8cUt3DLTrdNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66946007)(66556008)(44832011)(6512007)(6666004)(508600001)(6486002)(66476007)(186003)(86362001)(2906002)(31696002)(8676002)(38100700002)(2616005)(6506007)(83380400001)(8936002)(31686004)(5660300002)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXQzdWloZENXbFFyZjhHZVR2MlhiVFVVYWJMaWpmTzUvQU0xQlRMVEN0dldE?=
 =?utf-8?B?a2pwbC82QkdkWlcwWWZvaCtDK2lWL3RUQUMydXRQT1RoaGlIZUlwd1d3TkZC?=
 =?utf-8?B?SThUcWNQQnpXcGhjRElxVzczUEx3THEvQkhrczFCbXc1R0pGaFBGNkxiZ21h?=
 =?utf-8?B?c3VxeWxLd0xtTVU5TVhVVlVHS2ZSQVgyclNUVTJkeFlHMGREMmg2bHR2emVK?=
 =?utf-8?B?ampWMG5TQjBwSnNhTWFWL2JOUDBCT1crc3lTTEszVHd0K0kxVUgxQjVXV2w0?=
 =?utf-8?B?S1pObG9VV3dIK3Y3dTJSVkNNWTVaY0wrQlhEa1NIQXptamZOTE5VbTlUcmwz?=
 =?utf-8?B?VTlkN1VHNFgyQjZHZEl5RzhHYzlFK3FHdW9iYlZCTVJvd1M2clBCY0wrL2ZS?=
 =?utf-8?B?SXFDenptbkdlT1FEKytkYTYyUU9xam44dkpMVDZWdTZKQU9GQUY1a3R1amxv?=
 =?utf-8?B?NEdCcjkwMTFUSmd3SGEyTU5zMklyTTNmaDFZUE9pcHFWTkVjYkJpRU5mRlFs?=
 =?utf-8?B?bExPYjBNZ2Z6eDJSN1psTTNoOGpIcmRXUG5xUGR0WDU1Unp3Nll0dlBydXhX?=
 =?utf-8?B?NWZxc2gxcEdweXYvVmwyZEgzdS84b3psMDFwTGpNSE1EVXBOWVY3cnkrU210?=
 =?utf-8?B?alhOYWVBSnRnOHZSczFabUZxTUk1WXBvTFdCUlNwWStsRCtCRndYYmRLQWl6?=
 =?utf-8?B?K25vRDc0Z2g4dG5RWnJmVTE2VDJ4a3hFckhCUFdCbmRJTnFwZnZUNDVOVDBz?=
 =?utf-8?B?TysvNXpYVFNYQ3F4YXFSY1JUM0Fva1JoRHdMSDNucmtFTmlPOU8vQ1BhS3Ji?=
 =?utf-8?B?MWt5dS9yYTBsYU9LL1lPWUhVN1ozQmFQNE9iWE55WmtwaHZrUkpYSlFnZHNC?=
 =?utf-8?B?TGxBQnppZ21rU003MHNqbHZPME9xUUxLZHRMaXpsazZDdEM2VVRCaDJhc1Ri?=
 =?utf-8?B?YkdBY3pXMHdJd2xHWlY2OC8zMUNHSWNSRTk1N3F5Z1ZKZ21hMEQyRlpUWG9S?=
 =?utf-8?B?cnVWUzd6SEtmTU5NSG1uU3RQNW4rd0lEYkxvNEgzbFNoVlhlZ0lRakdXM1R0?=
 =?utf-8?B?MEdUQnlCVVpUQm84OVphbzVyL1ZBVnVHYWJjbDJsckpsWHdnUjhyRVM3UjdB?=
 =?utf-8?B?MUdXOVEwaW9zNzgzQjdOci9DMDhkelFKd0VqOXRyaTJPcGo5Rjd0U2pKUEJo?=
 =?utf-8?B?d2RySnZnSHJGQ3dhMVlUeHNjVUlUKzdKbjQ2UUdnYkhaOStTQVVpdzRHK2RT?=
 =?utf-8?B?WThKR1N6Si9tRU5TR1FMbEdGR3Y3QW56TlhnUHhVTEY4dDU4cTRYM1l6Vlpm?=
 =?utf-8?B?K2JRS21kSlF3UTljb3U3RDRPUXE2TUlRQUhpSHZ1bncrUGlSc1VJblNMYTVI?=
 =?utf-8?B?TXZWYXBZYXo2UXh5TUxybUw1eGJTc1Yzell1bWI3T01vd3NLZzBDaUFxOFhR?=
 =?utf-8?B?TW5sUm1oZUFTcHFaVEVibXhvb3ZHd21aZlZLNlhSUi9GUnI2MWxRMUtkcjJC?=
 =?utf-8?B?NUtLOGU4VDRqbG4xVUlYc2d1K3RKMEp0M2VyaUZ5WkY2UWJEa2hxUVlzdjBV?=
 =?utf-8?B?M0trNEZFV21FZWpGZFpMUmRwcTRlc2tsNFdvS2hLS2VDMXFOU3N2UUhIczJJ?=
 =?utf-8?B?YnVLTXhtQ2Q5QkFjU1NYY2FOVjVxRUpXbXZOdWJpOXBkcXhoMmdYczNwTnJL?=
 =?utf-8?B?cDRKdTdCeUJxUlJUeE52N01TdmtCbU9QZVBWOFNncGF6UUtDOXdZMzBRb3dv?=
 =?utf-8?B?Z3RKbHlUNUh3d0c0bjJaWlJHTXdPZUJteStuUWx4dlg4SGRhM0grd3JCUUZv?=
 =?utf-8?B?UC93RFZFcmM2Y2x3TDlwVUh2MEFaQ242eGZDR3ZwZERRRi9nbHVlaEszVUVM?=
 =?utf-8?B?bzI0M1VZWFVackV2dEw0cGxLOStzbHRRblIvOHVGMXJTS0NWS3ExN1lOVkJL?=
 =?utf-8?B?dEVTUG9GRTM4dVFsMmQzREYrZWJUeVdRNW1IUld4aEkxN1VROWNyV1RFbHNO?=
 =?utf-8?B?MGhDcWFZbG00WXRLYmowRXFua3NCQ2dVeDBIUlc3b1R4TzVvQlpXNzJoWFEv?=
 =?utf-8?B?U1NSRUk1ZFBaT056eDgyVFpiZmVYd2QrZWZsVE0wdnJ2UEtuSXNaajdGOWxG?=
 =?utf-8?B?ck1Pd1RscXdmMFpTbGNUWG9wS2VkQnpOUXB2b1YzcG1aRCtXU1kvLzV2ZEQx?=
 =?utf-8?B?QWJ2UXI5bFhFSWJkcXIyYThmTXVjbWFXMzlGbzc0RDBKTDF4OHc0L3pYbEkw?=
 =?utf-8?B?WE13VGpOb2xJUlFWTWFhcGUxL0pFRzBnbG4rZXRzMTZQMEk5bklRZFpmZ2dE?=
 =?utf-8?B?aE1GKzRMZ0IyVyt2dGtIeEtIZS8xeEwvSkF6c2pNQnRpaDRCck1hNkRIU1VD?=
 =?utf-8?Q?m6x+JjrOmU6Qclt9m3kO+eHEXuStaumO9CtO/vlkWXlby?=
X-MS-Exchange-AntiSpam-MessageData-1: 3B91KFwEWa8fWb3c+WdeGVBim3ttkL6VSVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54135113-3d22-41d0-7447-08da3162cb47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 02:22:41.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnqyJKjKqFfD1g2t95/JDbIc540KHuiKs+trseIK9TlrHU1jgaMEsnrlr4VI5Huq1mM++v0ZgEH0TlSwF7Urlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_09:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090010
X-Proofpoint-GUID: 1O4uoqffuvhQgY8ZYIUMIFEB66KSyO6g
X-Proofpoint-ORIG-GUID: 1O4uoqffuvhQgY8ZYIUMIFEB66KSyO6g
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/9/22 07:47, Qu Wenruo wrote:
> 
> 
> On 2022/5/9 10:15, Anand Jain wrote:
>> On 5/7/22 12:09, Qu Wenruo wrote:
>>> Btrfs defaults to max_inline=2K to make small writes inlined into
>>> metadata.
>>>
>>> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
>>> metadata usage, it should still cause less physical space used compared
>>> to a 4K regular extents.
>>>
>>> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
>>> users may find inlined extents causing too much space wasted, and want
>>> to convert those inlined extents back to regular extents.
>>>
>>> Unfortunately defrag will unconditionally skip all inline extents, no
>>> matter if the user is trying to converting them back to regular extents.
>>>
>>> So this patch will add a small exception for defrag_collect_targets() to
>>> allow defragging inline extents, if and only if the inlined extents are
>>> larger than max_inline, allowing users to convert them to regular ones.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


>>> ---
>>>   fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index 9d8e46815ee4..852c49565ab2 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct 
>>> btrfs_inode *inode,
>>>           if (!em)
>>>               break;
>>> -        /* Skip hole/inline/preallocated extents */
>>> -        if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
>>> +        /*
>>> +         * If the file extent is an inlined one, we may still want to
>>> +         * defrag it (fallthrough) if it will cause a regular extent.
>>> +         * This is for users who want to convert inline extents to
>>> +         * regular ones through max_inline= mount option.
>>> +         */
>>> +        if (em->block_start == EXTENT_MAP_INLINE &&
>>> +            em->len <= inode->root->fs_info->max_inline)
>>> +            goto next;
>>> +
>>> +        /* Skip hole/delalloc/preallocated extents */
>>> +        if (em->block_start == EXTENT_MAP_HOLE ||
>>> +            em->block_start == EXTENT_MAP_DELALLOC ||
>>>               test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>>               goto next;
>>> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct 
>>> btrfs_inode *inode,
>>>           if (em->len >= get_extent_max_capacity(em))
>>>               goto next;
>>
>>
>>> +        /*
>>> +         * For inline extent it should be the first extent and it
>>> +         * should not have a next extent.
>>> +         * If the inlined extent passed all above checks, just add it
>>> +         * for defrag, and be converted to regular extents.
>>> +         */
>>> +        if (em->block_start == EXTENT_MAP_INLINE)
>>> +            goto add;
>>> +
>>>           next_mergeable = 
>>> defrag_check_next_extent(&inode->vfs_inode, em,
>>>                           extent_thresh, newer_than, locked);
>>>           if (!next_mergeable) {
>> Why not also let the inline extent have the next_mergeable checked?
>> So the new regular extent will defrag. No?
> 
> You definitely forget the fact that inline extent should NOT have 
> regular extents following it.
> 
>>
>> -Anand
>>
> 
