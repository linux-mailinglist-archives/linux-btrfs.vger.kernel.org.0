Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68B2391167
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhEZHaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 03:30:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49122 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhEZHa3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 03:30:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q7GCAT166263;
        Wed, 26 May 2021 07:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9RO9ZM2rsU3KRHAPOVsxvzL92L7UdUrGxiUMX5mMXHI=;
 b=bMqGPpnYbnKzgTmrRdECjYBFwc4LwEEVs5jwzVuYxSVcsF2QwMnqZX9nX1ddJuWnoJo1
 IB/fN2VgooqeS563EfJ1i08t66/l+7br11mNDzJB4YEOIjQ6sfh8HeW8fj5iMQfGONvp
 kcPjaFu7iEbJRt6FUo8wQMDoxa5tEgKYVLuWgDT/bJW3wtuK2Rf7+aWCEyr7EIIiUFbz
 JYNRFebymIU16SKTBHKCaWPhfmW9kAmVuBerpsqApWmYlIbvAfVbtJhLwkxpKi/JWcZk
 G0H3EprnyRiImkbGO7JCJsjEu2sOrS+PvEVpdwuHIRCuZkRcgqyXueUrCsob5uHO6nun tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ptkp81tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 07:28:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q7GFoR158618;
        Wed, 26 May 2021 07:28:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 38qbqt0drn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 07:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR5MUUSo/yMv3ziRAugtcO36+XNHv/DHsWMz7Gn3Ie2mF+MNjUaoKH8xW1qcaeU+rO6+4ASTfzA26k1f5kNhiCCvzUJTBOtrX54L5iUJFxSpygG8pwipxFw9pssFG2x+kmX1sWFduHbcSWvBVefxufVRV3UaBFw8qK81qBsK8FjvqpdwTF/Yruf/CoBc6dbaZxyMil7UXLkM7g3TB2EHRhZS25cTV8NHvjlCpPFDP1Wk3fuUk58BUXVhmjIZqMNVK+GWHRjYrF/Qkkc5132g2urTnYzkfuTaqB09apnXVmcraskzPzGun8e5faxIHJgoboR2i3W0Y3yICagvo2tdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RO9ZM2rsU3KRHAPOVsxvzL92L7UdUrGxiUMX5mMXHI=;
 b=BOSMBdfvLQ9TJanu0zNtcBjYtbxdsjjpY9muMZIu42UuBKGZON7e+Gz0hnPazOT5K4EL4yDWzohiA62tJJyWJM4pU2Z7iO2NBxDQPMjkKWbT3Kzqyg0FG2AjD2cF46zLsuHMRSmGGOpd7WSSRAWDva934vS9HL3udFuu6mNhjL/k28ZRDffkdZq4ey+w0X52jahEVGw428xR7TScIzzbqW+H7eiSXT9Jr33pMFWNJhkf3YUOGy6VfjTT5XQpisbPm4ZLF9EYo4FEvE+zhmVRlsovpbGRn5VIeIg9kpA+qNf0SDeIpd3zpMqHW6GDtzRsHec4QoDcWThtmInm2IeMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RO9ZM2rsU3KRHAPOVsxvzL92L7UdUrGxiUMX5mMXHI=;
 b=GhwAr64eiuD3USsz0Hl82PZukUj7/eKgqyFRBXdQLW6FbFGi2l/UtcB2kPFWTD6kbzkmmPv79XXRMEGZ9nbdNbnZ+EMvxDtd6s2+x0qOzTSEDdmb6g9RjDB+4SB51ySd3zmXr99yD5XG1MpgOte5rgRy7V+Joht1WGmFTcky3jQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4095.namprd10.prod.outlook.com (2603:10b6:208:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 07:28:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 07:28:50 +0000
Subject: Re: [PATCH 5/9] btrfs: document byte swap optimization of
 root_item::flags accessors
To:     David Sterba <dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
 <aa044ee1e458071530d3f74f53cddc72010f3f63.1621961965.git.dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a57946af-b4c0-dd63-dad6-2635a542d9fe@oracle.com>
Date:   Wed, 26 May 2021 15:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <aa044ee1e458071530d3f74f53cddc72010f3f63.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR06CA0230.apcprd06.prod.outlook.com (2603:1096:4:ac::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 07:28:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd4cf51-e70b-4c13-aea9-08d92017e7ca
X-MS-TrafficTypeDiagnostic: MN2PR10MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40950BB8C5B3F5FB99119AEAE5249@MN2PR10MB4095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+oHug9lczNxi+ma0e76Y+rPIVp5KBl4200FZY/PBVfyscSbbg9txE2IWQVqgRRJVAr7ZAo1juMCxRSsYk0nGNo4iHY9i/JGu1HcEFVOcuRxusQhKMZrG41lG6byYN1mYCQB1CX47I5R4LeMGqy4DV4ihpHcXQ8u+sHmeKj0BoPiKcZyWQHe0pOmvzc5CEbQUDCscu4jloPKa5LGVFXGDunVfrDgi8WITGqwOuFY3kaDm3OeSN06rAxJB8ggYhod6vrsyb63It18t9FSq4iKm0r5gheT+ICeAjGrO4+sEWhNjKd1JXKoXtQ+8qRFECJsuyqAS7j2sDbn8HAK0BG+6QB+tC8fYUuIc9LIjCOVRijniouRo4ol1xQrJ+h0p8brhaHSUHwtLj2ckKlmSaNJxXgNMLb/nbe8axZW8sdi8PDvMNxA8eHYgybYRUYVnGod6Hw1d6Jqi1VE7M3Vdi2vODhyOfqp73AvMcauYBS8DZcj0GqRl0Aq0LGX3BKG4NWwWB5efTT0WMcOO4fn1ZZwCkti/PJxDO0cRdIaKWbaOoH8DXZ79wSRhnrXPFMEGFCJd2i9/KhFzx1F6zsaJRxGFD9GXhHgjfwxbBjLJlARAhxgUp/uwd2TPdMANbXkKK2zsbJUKsoJPnkbq81RC+tStQxLLUFr2w1xy1+XmxG/pc8ocszNaknhOJp5Efjg95kX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(31696002)(6666004)(66946007)(316002)(38100700002)(6486002)(2616005)(4326008)(8676002)(2906002)(5660300002)(16526019)(8936002)(478600001)(6916009)(4744005)(36756003)(186003)(31686004)(66476007)(44832011)(66556008)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clhkWG5Ldkp5SGY4ZXpadmF6UEp0MzRNU1VQcHBJMXdNK211aHV1bWd5WFI0?=
 =?utf-8?B?TTg2enRjdUtCcUwrdmhiM3hpUy9NTVZ6b2MzL3oyUVFpNUtMU1dNWlBiYnlx?=
 =?utf-8?B?akNDWkV6U0hBNGtrMUNydUNHVVZFcDdMRmM3dWZIc2ZvVnpKUkhJNjU5SXh3?=
 =?utf-8?B?U095cWpZRVRCRjlYNVVab3M2ZGNtMXFmMjFKcFJYWHJUbmJVMDZWZWtqaGZE?=
 =?utf-8?B?Q3FwQ281U29ybnIxT0lxVnpaY3ZYSWdHbVhkNVhyTEx1dlpEMlNPSkw5dXdk?=
 =?utf-8?B?ZWlxNXJrbUtxMHorbW5BOWpQRUMxREU3NXhjQ3BoNFp2OVk3RjlGQnRGTTkw?=
 =?utf-8?B?emM0QmlhMTl3NjRNY2Z3dnl0dCtxZnM2UzJTVkJSREdSNHNsNVAwTExHdkNL?=
 =?utf-8?B?UkFWVHExMlNlNUtxMm8ydGpnNlZ4bjZOQXR0MVI5dDJCdnZxcllsdjROcUI5?=
 =?utf-8?B?NXlMcnRBQWNDVGhRdFJkVnFCTElENnJSaHE1dXNObWh1NGJkditESG1zcHNt?=
 =?utf-8?B?WWhKd2V2MjZpaE5EZXluSVNmWXJCWEZWbjRyMXpvaHFrT2ZqR21sTytXS243?=
 =?utf-8?B?SU44WWQzL00rYnVuNjNpTnAwRS9HY0p2dytOOVg3SmZhL0doeSs4YTcrWkU3?=
 =?utf-8?B?L0piMlNGSGZ2RUpOVkk0RjNpYUVWRWJWRUd0amltaFlDNEJDbEJPT1FGcmVn?=
 =?utf-8?B?SDVCbFNNczNhRG02UTVBQ1FOcmplVERwOUUzOXlhbGVaendWcytzMkRRekhy?=
 =?utf-8?B?aFpHejIyOTRjTHY1UXl3QzRRVXIzWUxSb1dVd1ZkaGd2VEtpRlhLS21DL2ZU?=
 =?utf-8?B?YjdkZE5lYktMK1paeFg5TXNPcStvdGxSeUkyakhYTGlpN2FqK09FQ2NXNGRp?=
 =?utf-8?B?L3VjL0NaYisweWlBWU02eHVDZlpsckdveFNVQkU1cHBGWXJlN0FVcGFjTkFu?=
 =?utf-8?B?WUVDeWVvUFVpaWN5TGlvMTl1anZXUW8yWXlnY1BtVEVwcVVnbURTeWpTT2pz?=
 =?utf-8?B?ejlYakdFczdqMjUzNDZGZUhwektzbHA0alJGN0g0KzN0YkxMc0RITlpYbjRB?=
 =?utf-8?B?ZzFTQklkbGNIeHVjMTNya2NNZTFMdjdnb01aNUFNVVN1bzRFaisxWnA2QlpU?=
 =?utf-8?B?a0ttQmhUdXluTHo0czNMYWJTZFNEZTlHL3RPbTRwL2xrRHRYTGl5MUZNQ3Nl?=
 =?utf-8?B?c0VGdzJvYUxtdGJnNHo1akhFZHRrSHUyeGtqaXIyTldPQnl0c1FhQ2d5T1I4?=
 =?utf-8?B?TXFvREFvck16T2d5ektJdFcxd3dzbnc1WnNKZnRXWXlrdmxQVS9BWUVDS0Zv?=
 =?utf-8?B?NFBkTlRyYnpaZ1NFOWRxd2xvRFdDRkFPMS9XanA3ekFUSnltcTFtOThUUTll?=
 =?utf-8?B?cnFrYmJWbXYzanJWZTlEK2pzci9rdS9UNzFMRjFsNitqd1NxWEJSNjN6WVBt?=
 =?utf-8?B?UGpBMUJXTFVxTzVLcW1KV2diY2J5Z2l4TVRhdUJHTERua3dtWmRnZjRpM3BR?=
 =?utf-8?B?Qkl0cjNJbGxKK0V2TmcwYStyVktGV2JiQmJjdksxVWVXN0RDc3pCdDJxQ2pa?=
 =?utf-8?B?RjlVenRaeFRlSGcrdzk5TnRFRTJRWkE1VE5WdXNSay9LTlNFNjlZeGVNdU5H?=
 =?utf-8?B?V3ZuTlZWSHhWYTVINDQ1U0NyV3FRUUovN1pOeUxRUStSQ0VVNFJsdzgvNXpz?=
 =?utf-8?B?bFh4NXNxTGhERWtvN09RL2swTVlkbVhTVUIyLzBMR0c1cUpjMnJ4L0c4ckkx?=
 =?utf-8?B?SGxyZzB2UFdPV1M2V3dhUXcvQmYyM3NtZTNna1NCSmd5KzMzL3RqTTYxOUc3?=
 =?utf-8?B?OEJNSGxrMmF3cW1MUi9Ua3Z0N3FYcDVRQ05Zb1hUZHNZeDFnWnBvVWo3c0s4?=
 =?utf-8?Q?1LINvqQLBexyb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4cf51-e70b-4c13-aea9-08d92017e7ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 07:28:49.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgdIbgv6VZEFvgP4Knujdzzmt4JsEHNNMYTv/jktpQatD4ZSl+3Mf95wtmLcfgHV0N5OGCMveSsO754pBrCHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260047
X-Proofpoint-GUID: 1kcmlDN4yRu1SLBdg01RTdVTYbbzgPZV
X-Proofpoint-ORIG-GUID: 1kcmlDN4yRu1SLBdg01RTdVTYbbzgPZV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/ctree.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d78cb2d89d7e..a3b628ea4d64 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2216,11 +2216,13 @@ BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
>   
>   static inline bool btrfs_root_readonly(const struct btrfs_root *root)
>   {
> +	/* Byte-swap the constant at compile time, root_item::flags is LE */
>   	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
>   }
>   
>   static inline bool btrfs_root_dead(const struct btrfs_root *root)
>   {
> +	/* Byte-swap the constant at compile time, root_item::flags is LE */
>   	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
>   }
>   
> 

