Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C583928C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhE0Hp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 03:45:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE0Hpz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 03:45:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R7TVmZ084504;
        Thu, 27 May 2021 07:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A4pkcnBjHqxZQSqu4uJNyiU4VT82bBdfiJX048OxJXY=;
 b=DEcu930DrfjkZcyk/j8yRBxDd1CA/L0xKUeqSqoNkc2XVUNqWkHLEX6PLQt5vTkUdRc9
 yYj4WGyJj+uktIA17FMuu7pH6QnQwEuh6NE4PG4p1YdLi8MCnXz0U1wbCQj//4cEUGPB
 1V+E9VBFoElOQKUTdulAOu8wTOTU2KxG4dcRnhF2wLJbeBwHez+lRJalY72Imx5smVcy
 iNecvcJSVyv1q9NJ/pMoQiy0quDe4x/pgxlHlOkodlRJ/LM54+dG9Jjri64dj0er3PHf
 eVZug5iJQzP4X3ZSy1VB53SuHiL5IxkaNwI8SgUdguo6zPZXuvQsLvgej+QhPWly6YXR JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38rne46ugu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 07:44:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R7V7YP050367;
        Thu, 27 May 2021 07:44:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3020.oracle.com with ESMTP id 38rehfdsjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 07:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8aqxxFPaIYlZNOpIp7r4SVbYLtBCJDu+sJScSSz73rDNzD36VrSmEsJvaCiIHeZo+d5qfYWgBk3vGLU+8TDPnW+ydOZP9X0q3vNQP43O/EE7r01JZ7f+/+cxNuULUIWR7GRFK9s9aIDQFo5DPgIpfKxXozBYwCzjSFzUpFauBJ8bi6M9+Uq8/e9aCMOviPm0Ec1ivE8miz148GQnXg2J5ep4aAbNIusEAkXRlfr2S4RcG/t7073UMI2PFfTT5JDdC2yb+JQFswRqz5BsteZKjzHO7WcHSbqSMDUBL3BVLGeiiqky9Z/fqn5Dt6e7OB/Xnl553HLp05Cn5Wfnk28pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4pkcnBjHqxZQSqu4uJNyiU4VT82bBdfiJX048OxJXY=;
 b=WLwjM0zfCXKL3E+U/J4nDyDqItPkHzuTb/O/PiCH9Ks5ENTS5H8GqAhOAitOL53f14yDx+8cXpS5OTyvpxlCkDq5H8cfoaOgW4HpTUdFSUGUbRpFvcfUY9/c8X1/vTPf8Ko890r05gG+G7Ybkm/1ow4Gjlka4WwGMdohvEXSypy6E5azRX8DhQnM6VVCXSTnNnFFQCw4Wlbl51RxBgihB34hve8AsU9Q3m9BlbM7m6W8NDc52sfUQABOeNYEiej5ktcjS5uu/3Wr6ctLRE4ANrHgu68c1KwYDDdX2AqkGJhXTHxUuXcCszBCzIx6pQoo+7AlJdAdNKtJiFO6RHxEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4pkcnBjHqxZQSqu4uJNyiU4VT82bBdfiJX048OxJXY=;
 b=H91cWW8yUiDp7G8t/i+j7GRHsGYSvZjE7Biu6sVlIjhpwtv5Mi8Dd9LDZ+peyjwg6+A7isOjYuDoDNpmWCeSr2w4UlbZtzVhwKljlBy3fGFMy/Ap3rOxtaFiQZ+HZZ39SFtK6o7gK4OvoUttkVBamEEjccLSwUs7KsezORmVOCU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4096.namprd10.prod.outlook.com (2603:10b6:208:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Thu, 27 May
 2021 07:43:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 07:43:55 +0000
Subject: Re: [PATCH 3/6] btrfs: introduce try-lock semantics for exclusive op
 start
To:     David Sterba <dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
 <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <dc12e388-70b9-1349-1e20-85a7fc60d350@oracle.com>
Date:   Thu, 27 May 2021 15:43:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:902d:5eac:1481:84ee]
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:902d:5eac:1481:84ee] (2406:3003:2006:2288:902d:5eac:1481:84ee) by SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 07:43:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d25589f1-5c78-4f0c-53c7-08d920e32d87
X-MS-TrafficTypeDiagnostic: MN2PR10MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4096C4C7F6872E36817B2EF2E5239@MN2PR10MB4096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmZAFSHBzex6EMHd0x7ZinUlTdN23T0EERocHGbvsodLbezweVAcVdh5K0WsHQs4s8Besv7XvxE8uwepHDdvHhqmeJiI8Ju5f3PM/BCB4u6SIbEZSyE5z2QW6/5R6STkOeF8B8N4xvkISK5Vw/MVxH9Z/v488ZLMtST0WFblXKUV0NsQqs839SUwF66uXIse31G/XxzSBlcR0Ki8YWNTx90CUE+70qzvhIu7W1VTJYicijE1fJOBx+226W+VWQKeBCSQrHTnHTDm9IBN9U5ngLcyxCYrUPjNBWWfMGinCeNbUFeatrWL+W3P6J9BPRF5u28o8cIe2vD7e7tcqtOvJ6RwjsEs6YJFaItuSGSbHAlkNVrDH8ryV7N37rAsIN2wNPm/CnqPyiA29b8XwmZaUygvanY8Aerg3dGkvyDiv7FWp9XLRxcBizC77htOgjMYlGna/tsa+5LX9yWbGoWbchjp2mTC1E4pDErDpHxeWRCDdI7LhIZ+avSHgT51BcKgapUvq++C3gygdtgd3gm0Ohil7Rp2xPr1sV5feZJ/ujz5j0tDFRnm5GQqhgbKvQKup8C4BWmQbJDwin1lEqlq4tLdT/cUo+ioRTFrFinwfKoQmj+eUFODW39js1f1lgDRC+2RT+KtFxKV0D5Kjc7w0tjK45NuuSbdyEyj/f+FxugC4w4zSvH1qWpn+AGeRWxl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(136003)(346002)(4326008)(38100700002)(6916009)(44832011)(186003)(8676002)(53546011)(16526019)(36756003)(8936002)(6666004)(66946007)(83380400001)(316002)(478600001)(66476007)(2906002)(31686004)(31696002)(5660300002)(2616005)(66556008)(86362001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVlHZTlFakx1eHNOTXdSTjZCT3dGdmE3U3BDTVVhenVPVmNvMkt4Skdtejkz?=
 =?utf-8?B?MHBKeHdKNkhvZE5XQy9iMGJSSkFTMDFkRlFaOTAyNnJaTDd2Vmpoc3ltV0Ni?=
 =?utf-8?B?MHNxWDYzbnVqWUxSZTRwTVd5SFdodStOTEl2bURyZWVBNk80NnhvNFNxaHdt?=
 =?utf-8?B?NUdqbXFaSzh4SmlDMWdwdFZYMW9IZDNpMUU0blBrN2ZaS2VVanY3ekp1SkJO?=
 =?utf-8?B?UVRwbHcyY3AybWl0a1F5azFBd0FFSmttd2ZHRitQaWtMUVVIenZ4bEFjeXBp?=
 =?utf-8?B?bm9vd1R2M3puRFV3R3ZQUUZIV1JhUmRGM1BtT2xBbkw0Ky90T1JEZHJtTk5Z?=
 =?utf-8?B?c1JRL2toVFRGSGtVOVZRWjBYMGxjM1pabmE1RTArQlVuUDkwV2sya1MzZWQv?=
 =?utf-8?B?bnNDMWJoSkw3Y2FnUnduWWU0UGk1TFlaMzZiOFJ1clhoQThJajIveVhORk95?=
 =?utf-8?B?TnRIL1duUHR3dFQxdlplMll5c2RBcnZIcU1IbGtoM0tYM3JwVWJvMlZBNWcy?=
 =?utf-8?B?bktEM0xrODVOdkFCdHErSUJ2UjhXMWlORHB4bFdrL3NkNU91NHB1VzJmbzVQ?=
 =?utf-8?B?cThxU1BaUmF0VjJIL3dtck9OdWVNN2tZRHg2ZTRxOE1XYVFjcFBKYjgwRUEr?=
 =?utf-8?B?MmRuMEltbWJGRVhtRlRoSG5pdGoySXZUR3JhelJza0F1OFh0YzUzYnRHS1la?=
 =?utf-8?B?eHlQd2c1Nm5lOVZpZVhIWVZ1T09uSDJxY2puNktZczdNbUlpbFJ6a2g0c3NE?=
 =?utf-8?B?LzBjTElHbUN1SnV3cWkvZWJBNWx1U05VYUt0a2l1bDcyaW1qU3lLQkZhTnNY?=
 =?utf-8?B?ZmNIRkpnMHE0UEEvM3ByYlViaXNtRG5hT1pYZklkNGVFL0pvUWRnZ3NJblkr?=
 =?utf-8?B?b21EUlg2Y29nUGd1TSt3UW1KN1BNN3JkWU5ORmtJNkNnSFZ3QlRVL3BEYU1M?=
 =?utf-8?B?S2FOaytHeTkxcEdLOGxGU3pQbFBzVU4zL3ZZcGNNQjFYTC9veUNrSTZITUdL?=
 =?utf-8?B?SWpLOFhXR3ZyWnNLUzZLV1J0cHZjdHlJRUN2MzQwRmRJdUszUUpxTHgzSjBI?=
 =?utf-8?B?OUpRSTBTOVdjZi96cThCY0pXTTZnbVo1QmdvT1FwZXh3bFNFYmFJVUNKQ0tv?=
 =?utf-8?B?bGZVSGgvUTJGS1QxeGxyMFAwcWdZZjBvMEhJWHJuK2NsczRZa2FLOHdMcXJT?=
 =?utf-8?B?N0lDOUdxd0tNQi81L2xnMFBZYXhWbGxRK3gvcEhXa1JYYVFPeEljanFrTWhW?=
 =?utf-8?B?UkUrakQwVnRTc2JGejBJQjdtYk5oVGNQRmtlOU14UkV3SFNpd1J0bnFMUExJ?=
 =?utf-8?B?QzB6QXp4QWo2bkw3OGJlWnVtcEc2MWpYWkJGdm5zQzcyQjA5RjJBN2REclN1?=
 =?utf-8?B?c3B4dEIwYmZtdGVGRXVLSHF5TkFtT1hYMFpHUDlPbmg3SmViWHZCdmpsVm84?=
 =?utf-8?B?dEUwVVR2UDUxclVvQlhRN3QrSEdNZjJUZ1BHb2RlUi9mY3hRS1hwRWxabHBJ?=
 =?utf-8?B?U0FRRS9GKzF2ZFE4Qm1lRmxkTHByZUs1VDZOcjFTVVMxTkhGdGlyeU1acGRY?=
 =?utf-8?B?eGhWZWw5MzFLd3NCMFFWQWQyL2JvV09nNnF6cC82VmJxbnIvdWo0ZXBUcEZi?=
 =?utf-8?B?VGJZUGxkZHhKUHBJbnE3SjFUZEx2NUZFNXY0SjlVRlFyR05OaEwybDdoNGNx?=
 =?utf-8?B?VW9RUDkrTkdWSC9mZkRvUXZnV04vNWNvUlZJcWFSYzBMbEdHdlRTNjQ5cFRT?=
 =?utf-8?B?TkdlRUZyb0Z1bGlyTWlLNVlMWmJuRTlTajdhaHRQZkorRy94VExGVW5tTWZ4?=
 =?utf-8?B?Ukp0LzFTVnMvQWpkbzVUck1EeG1EMi9BaHZJOTVpZWZPWlIrUGJORTNIQzJk?=
 =?utf-8?Q?Xlp33S4Qpspgy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25589f1-5c78-4f0c-53c7-08d920e32d87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:43:54.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtI1tVG7QxECPG2tm/H0IpwlmUDTxMwUjpPEVsP66N+uyTPl16jSXDix/HHGw+f2yrrrb/nPrPHolNMnaTJFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270051
X-Proofpoint-ORIG-GUID: 7CAXUMUNhtj49D7An0R0_cwBmGmqafBk
X-Proofpoint-GUID: 7CAXUMUNhtj49D7An0R0_cwBmGmqafBk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270051
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/2021 20:06, David Sterba wrote:
> Add try-lock for exclusive operation start to allow callers to do more
> checks. The same operation must already be running. The try-lock and
> unlock must pair and are a substitute for btrfs_exclop_start, thus it
> must also pair with btrfs_exclop_finish to release the exclop context.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/ctree.h |  3 +++
>   fs/btrfs/ioctl.c | 26 ++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 3dfc32a3ebab..0dffc06b5ad4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3231,6 +3231,9 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
>   			       struct btrfs_ioctl_balance_args *bargs);
>   bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
>   			enum btrfs_exclusive_operation type);
> +bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
> +				 enum btrfs_exclusive_operation type);
> +void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
>   void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
>   
>   /* file.c */
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c4e710ea08ba..cacd6ee17d8e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -371,6 +371,32 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
>   	return ret;
>   }
>   
> +/*
> + * Conditionally allow to enter the exclusive operation in case it's compatible
> + * with the running one.  This must be paired with btrfs_exclop_start_unlock and
> + * btrfs_exclop_finish.
> + *
> + * Compatibility:
> + * - the same type is already running
> + * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
> + *   must check the condition first that would allow none -> @type
> + */
> +bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
> +				 enum btrfs_exclusive_operation type)
> +{
> +	spin_lock(&fs_info->super_lock);
> +	if (fs_info->exclusive_operation == type)
> +		return true;
> +
> +	spin_unlock(&fs_info->super_lock);
> +	return false;
> +}
> +

  Sorry for the late comment.
  Nit:
  This function implements a conditional lock. But the function name
  misleads to some operation similar to spin_trylock() or
  mutex_trylock(). How about btrfs_exclop_start_cond_lock() instead?
  Otherwise, looks good.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> +void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
> +{
> +	spin_unlock(&fs_info->super_lock);
> +}
> +
>   void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
>   {
>   	spin_lock(&fs_info->super_lock);
> 

