Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1C219D5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGIKP1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 06:15:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:28072 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgGIKP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1594289723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=y/54e0TM7KYS9gEHYTYTnI6610NeYNcx2l1YY9xYvmE=;
        b=LYLMvQYdOklHd2p/XdPHdtvDRjVdvqt2RyKVDBA0wQZ0afOoLiXsVeqXnds3d1shitkQpC
        ONYmtZ9Be3Lu2aa1YrM3sdi/fJCcfNXsMxMVVnhmYevL4ZmCO9lIM9iIWJU8qSsfuPh9MT
        VBdQpGxEbt/H0tqzWLFB+BClYfSOWJo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-XTDw-eRNNJCK5cG2981yEg-1; Thu, 09 Jul 2020 12:15:21 +0200
X-MC-Unique: XTDw-eRNNJCK5cG2981yEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVoWcGr2C9jR7euPW0QPxM8mMug2U1qAHdQXP9g5MphRMyst9Mapoj93/taH5e2LQH54yKAFYd16W3/unUeTlmWzUZNP4+/tc4scnP3wFOQUZX30DZObUiLu5i110/1LAebgmm9GBJ6nyCALoKI0eVCVJtsiebbc6d95anANadMAdAjVX2eT8chqZ/SWa5jtlKEAC7cJUzLI+C1tdMafwBJt6n4VuQ8nK6b42hBMJtPFv32SMWHNzQad9qXq+RA/Ko8aj3Max6aJVtnyjvW+qzRQ7lVYyUyXCXPpFEfj1MuP44EvuM91Upy3OSCyYt6+Rpe/i/DnjHof1ZVzNCLF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZptz/bnKY1by5thHG6Xd+Se3BlJy0HA0SVFqhnNU9c=;
 b=aHifIL8eU0Ga+GIGypM4mI2P++FskIdMfz4aV2B6pN4+rk2UIH2UZLJRsnOd5Ykz/EW3AeQo2ET3s1sbf89kzGr9+HAoWOGxb30xGk51abzK2oY/gJRo6lUYVqN0oJpl4wzE9qjnv0uMIzFDzn0SxyaYBPEVmYnTxELypLE4hOqSRaXUZ389vAZTRz6H/+x67jTKYlVczCC74EWqXERY0pTPRdP8XSjkQFuUEHy4AYZ13HC1WzNjUtZdbITEeO1t/a/CrDOr/qyF2DtvuB/l1W808mKMq0fv8CH6W0oSdDhGq0IBCc1SnQUYjrehxeGutoXc+BpGgDlGiF9VtbDH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6097.eurprd04.prod.outlook.com (2603:10a6:208:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 10:15:20 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 10:15:20 +0000
Subject: Re: [PATCH v2 2/2] btrfs: relocation: review the call sites which can
 be interruped by signal
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200709083333.137927-1-wqu@suse.com>
 <20200709083333.137927-2-wqu@suse.com> <20200709095413.GF28832@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <76a28b23-f1f6-1dbe-05f1-f642747564f9@suse.com>
Date:   Thu, 9 Jul 2020 18:15:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200709095413.GF28832@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 10:15:18 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78df6823-4aa0-49cf-bedf-08d823f0fbfa
X-MS-TrafficTypeDiagnostic: AM0PR04MB6097:
X-Microsoft-Antispam-PRVS: <AM0PR04MB609769B0138F8EE23271D6B2D6640@AM0PR04MB6097.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baVmr5wnKyng0uj0d/nCciEeTx2thZVMfxLrDZBcIO0tTjHHzOlvDB74C35zoUUKy9Zwz9E9DrZHUT2iig7U/cxioXoIQ1BczGGZWzCkIl8VCliTTP/cfjmHxckhmb0bdaVGrfJA5h7KFo0lGA8C1qn8nNjHMXR5mnUmMkfpQTefa2K8Ki7TxjqsMlbD6Cu7sDd637N7nK0TGpQ1+UuePRPfT5f1awMPYazlyTTWLU1WScv7HDPqLHxopGM7POWjN86AkCKDeZUlW2yQOF5R3TXfX4fnlrkYC2YKwW/GtOUZ8GrEfKQt3OcE82fErRD3Plk0LvZRyksPDP6O3NoowR1sZTcXQ0oeWr5LcpuJFNAv0TYTz0Gnkwawi7GvbS5Y8j0kCTFdzj2zUoPIIhvelEOntqL1hfw4V73M3mjx8+xX5ZaY7pfT86Qo3Wnfzgwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(6666004)(31686004)(6486002)(6706004)(26005)(956004)(2616005)(83380400001)(16576012)(66476007)(8936002)(52116002)(36756003)(86362001)(66556008)(186003)(31696002)(316002)(16526019)(5660300002)(2906002)(66946007)(478600001)(8676002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O29Hi04TNcrO6WtRr3qtlbBteGm9/9NSUK8m0e9v2GT1uXnVhzO36oMfsKk5/i4Ukwkgh+aX6BM/5DjYku1s02WEIoqRmAD+T/gJsM2XjWCpwuj+bAK8cOvgb1TOSTv4tw8qU57Lf/Qpph4K6zpahiswVxYVRxh/bTxlezF5UBgv98+aKwRoL0XVtvmiMlkEuKIKIaJm6d3Unl1tueyzT4nnrS/gresZatIlm/TMVz/rnqcWvVk/+VCpyaELcTPvmJ6lFMYhMd5Vyh2/FTAG8E9aNWf1b/cAjF7lNKsorgi+1RO/9fJKrw/6W7vHKxrnDiyycaWaDxsgGpY+dldtLfciwP9Mi2crF4LdkD+ty1H8D3NxXULY9g33hrBwqBT5EN9B0Bcspl9Cjx3lt89rvfaJbEZk7oPZFQ92EYbedT0j/hXR6/MqgJNfhC5aHzId/g1EoofKcyoTM2I56X3lLNe4svevBEBzev1sC896EcA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df6823-4aa0-49cf-bedf-08d823f0fbfa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 10:15:20.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT4ba0XznmDuN2bG8ok8BO6pMV4f8Ivh5rjmZqrPiBT6FZngMcNAlKeRvIoyCtzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/9 =E4=B8=8B=E5=8D=885:54, David Sterba wrote:
> On Thu, Jul 09, 2020 at 04:33:33PM +0800, Qu Wenruo wrote:
>> Since most metadata reservation calls can return -EINTR when get
>> interruped by fatal signal, we need to review the all the metadata
>> reservation call sites.
>>
>> In relocation code, the metadata reservation happens in the following
>> sites:
>> - btrfs_block_rsv_refill() in merge_reloc_root()
>>   merge_reloc_root() is a pretty critial section, we don't want get
>>   interrupted by signal, so change the flush status to
>>   BTRFS_RESERVE_FLUSH_LIMIT, so it won't get interrupted by signal.
>>   Since such change can be ENPSPC-prone, also shrink the amount of
>>   metadata to reserve a little to avoid deadly ENOSPC there.
>>
>> - btrfs_block_rsv_refill() in reserve_metadata_space()
>>   It calls with BTRFS_RESERVE_FLUSH_LIMIT, which won't get interrupred
>>   by signal.
>=20
> This semantics of BTRFS_RESERVE_FLUSH_LIMIT regarding signals should be
> documented, right now there's a comment but says something about avoidig
> deadlocks.
>=20
>> - btrfs_block_rsv_refill() in prepare_to_relocate()
>> - btrfs_block_rsv_add() in prepare_to_relocate()
>> - btrfs_block_rsv_refill() in relocate_block_group()
>> - btrfs_delalloc_reserve_metadata() in relocate_file_extent_cluster()
>> - btrfs_start_transaction() in relocate_block_group()
>> - btrfs_start_transaction() in create_reloc_inode()
>>   Can be interruped by fatal signal and we can handle it easily.
>>   For these call sites, just catch the -EINTR value in btrfs_balance()
>>   and count them as canceled.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 13 +++++++++++--
>>  fs/btrfs/volumes.c    |  2 +-
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 2b869fb2e62c..23914edd4710 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1686,12 +1686,21 @@ static noinline_for_stack int merge_reloc_root(s=
truct reloc_control *rc,
>>  		btrfs_unlock_up_safe(path, 0);
>>  	}
>> =20
>> -	min_reserved =3D fs_info->nodesize * (BTRFS_MAX_LEVEL - 1) * 2;
>> +	/*
>> +	 * In merge_reloc_root(), we modify the upper level pointer to swap
>> +	 * the tree blocks between reloc tree and subvolume tree.
>> +	 * Thus for tree block COW, we COW at most from level 1 to root level
>> +	 * for each tree.
>> +	 *
>> +	 * Thus the needed metadata space is at most root_level * nodesize,
>> +	 * and * 2 since we have two trees to COW.
>> +	 */
>> +	min_reserved =3D fs_info->nodesize * btrfs_root_level(root_item) * 2;
>>  	memset(&next_key, 0, sizeof(next_key));
>> =20
>>  	while (1) {
>>  		ret =3D btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
>> -					     BTRFS_RESERVE_FLUSH_ALL);
>> +					     BTRFS_RESERVE_FLUSH_LIMIT);
>>  		if (ret) {
>>  			err =3D ret;
>>  			goto out;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index aabc6c922e04..d60df30bdc47 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4135,7 +4135,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>>  	mutex_lock(&fs_info->balance_mutex);
>>  	if (ret =3D=3D -ECANCELED && atomic_read(&fs_info->balance_pause_req))
>>  		btrfs_info(fs_info, "balance: paused");
>> -	else if (ret =3D=3D -ECANCELED && atomic_read(&fs_info->balance_cancel=
_req))
>> +	else if (ret =3D=3D -ECANCELED  || ret =3D=3D -EINTR)
>=20
> Why do you remove atomic_read(&fs_info->balance_cancel_req) ?

Because now btrfs_should_cancel_balance() can return ECANCELED without
balance_cancel_req increased due to pending fatal signal.

>=20
>>  		btrfs_info(fs_info, "balance: canceled");
>=20
> I'm not sure if it would be useful to print the reason, like
>=20
> - 'canceled: user request'
> - 'canceled: interrupted'

To me, if user interrupt the balance progress, it's obvious they want to
cancel it.
Thus no need to distinguish btrfs balance cancel and signal cancel.

Thanks,
Qu

>=20
>>  	else
>>  		btrfs_info(fs_info, "balance: ended with status: %d", ret);
>> --=20
>> 2.27.0

