Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4B213A8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGCNCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 09:02:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35624 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgGCNCA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 09:02:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-pMb60ET0NZ6BzhfzFh1EGQ-1; Fri, 03 Jul 2020 15:01:55 +0200
X-MC-Unique: pMb60ET0NZ6BzhfzFh1EGQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgpkgSI/G2f73UQZ5vwLCpxxGxV73cEKiMQ8OsmM9MtFetZYGfMYpVk1/2lW+c1VmscTtEHgylPD2B0Qhvy3zbROwj8lCrFZbMqqe+OJ5bai5gkzAjOX9qWNjpUgNTqLKvZXX6JLpjampB4UnHkVoEtZ1qAx5EOyg5SUMkBwdqQAAWG4+oP7nDjYvnjnfAxo23My5Ex3ep9EecGuCqKIimNw95r9b/WEYkqTq4R1XrN841RE2d6PKyuR/nU6XoD3JKW9ZoMJOh5YzoAN8L+SnEJQShBdv5Qp34XimN9u/EhEXFiRz5D/n8G0/GVh2+t3lEpmxjQXxJQ5qCrcsLqOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kPMjHof8YouxLYE5JuInX1MGdlUU3BNJY3p+oGcjKc=;
 b=QzDaxE04x5jD5RYWOaKOjelNbhPasKKNN+5RW9iG4lZvDcyYkdZAfW8rgSOdIkU4DnLA4wNNeTl23JwFK/JYaDaXFQqKtJREsQzG9L8tDNMkAzhig2Uidoxkad5QjF0S8bckojJonzgc2ZyXk+fvdr7RkD/Uwk9miLJKT3e5RfC7XEcV4eGY5xa84WqmrFLpPAXANRWEMyU+OQ7UqGh2OYXlHTwVhGnzAwloR4PJoIQOxkGp29xuqtxbBCnuhlKfYrENDd65jUgpao8+rZBvl1Dub6yKJ/Z9enZ+2y/aIWOulaGQafomTKNrtZItesPWzVDaT4vhY0Z7gJQbaZ18iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 13:01:54 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:01:54 +0000
Subject: Re: [PATCH] btrfs: discard: reduce the block group ref when grabbing
 from unused block group list
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        David Sterba <dsterba@suse.cz>
References: <20200703070550.39299-1-wqu@suse.com>
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
Message-ID: <4c44286d-bdaf-3598-e3b7-9844b92617b6@suse.com>
Date:   Fri, 3 Jul 2020 21:01:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200703070550.39299-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4kqRLThbir1yaVeQKpAT5QwgsfQQTQ7Vl"
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 13:01:51 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7f9ab0-2efd-4d19-8ac4-08d81f51421e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:
X-Microsoft-Antispam-PRVS: <AM0PR04MB704475B8DC75AE1A3C38D58AD66A0@AM0PR04MB7044.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7+wSfKXy/CdV8HLuw/7/sLbzY4HkjAsfV8QTb211HAIW4Occ1So1hg/dmEchH1rP7rbTg+04C5LK6r5VsjGl0ISiGMRGty2A6f4xRix6yZTxbD/niTUu/7WcGKDuDjcps0watc45j1mes04g1leZ8wvYUxOU3ML3AOSRMD6Ld/c9I7CuSUH+ZvmT/Hlf6Mgtg8juEdLp2qTYrUDmLLaOPGfy+dqvVH3eNzE+aBr2EzK0P8c1LurK3+begL/6awqZp42u8lVWa80c5dx2Bl+rgO5IRV2XzP7gjkc7novvVDyh1mUwtCSVHTknea+70zwQnsn6lMFuTbj3M9zdjIQly08uYz3nMWHjz78hDi5O9KweoPcuzLlUgYVx1DZ76q5azjxOtxa4swbCfaB+YO4xnySS1YGJdQ8pIH5pK0fr326S/J9ABZvv6CZDnUs485S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(39860400002)(396003)(21480400003)(52116002)(956004)(2616005)(86362001)(66946007)(26005)(186003)(6666004)(66556008)(66476007)(83380400001)(31686004)(36756003)(33964004)(8936002)(31696002)(6916009)(6706004)(4326008)(16526019)(2906002)(8676002)(5660300002)(6486002)(235185007)(54906003)(16576012)(316002)(478600001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pxnimuP9faoj65A4KHV1hO7XofzROTnSECtUF2ale34ue8WwnjETsC+gHHADDHx4JYA8cfg8w8yd597bzNUC+ZGm/ePCI8MnIlWckSb3enpFnKlcXw9uLDcn0IhvE38iWZs5Aq2yDcj/iAXyEKvwf+PAEyNlUH1Shhe7qZxo8TsaXWZo4yiI9tXzP1xXDj5mAUSXccCDOuPhvSPg4uf4cHTsE9sOjJvnlqTVwW4xq1nDU1BnBHhvmg4tFlfsrrWmze9pi/WpqJebWGPMAuPxrbx8UUXJFJ0Q8/Jbzi5HvjoNptjHc25gffDF0u2AZxAIuIwn+LOelIXEd+XVsXXavN5tjDnslFM7W7bdFRm5BQWwaIpfb0QyCZbyfOd+srjSwE3qfl0X20dJWZAVuvIFsXQbVCZ1VzEybm7hOc/vCUWoAU8Ah/OVbcqxOcXrKb+VX6wQog4vKExTZV9bup7id4mVBZtIxAqWaROYWFryiB0=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7f9ab0-2efd-4d19-8ac4-08d81f51421e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 13:01:54.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8snLNzwHv0qplAXEU+5kou1gwHmprl8MIVrWGVZFcznj+kVPH0yNHrS8Czlu2wJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--4kqRLThbir1yaVeQKpAT5QwgsfQQTQ7Vl
Content-Type: multipart/mixed; boundary="LJhGpr9lnpkMF45A6cbrBPKBiJKhAuR2V"

--LJhGpr9lnpkMF45A6cbrBPKBiJKhAuR2V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/3 =E4=B8=8B=E5=8D=883:05, Qu Wenruo wrote:
> [BUG]
> The following small test script can trigger ASSERT() at unmount time:
>=20
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   mount -o remount,discard=3Dasync $mnt
>   umount $mnt
>=20
> The call trace:
>   assertion failed: atomic_read(&block_group->count) =3D=3D 1, in fs/bt=
rfs/block-group.c:3431
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ctree.h:3204!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 4 PID: 10389 Comm: umount Tainted: G           O      5.8.0-rc3-=
custom+ #68
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/=
2015
>   Call Trace:
>    btrfs_free_block_groups.cold+0x22/0x55 [btrfs]
>    close_ctree+0x2cb/0x323 [btrfs]
>    btrfs_put_super+0x15/0x17 [btrfs]
>    generic_shutdown_super+0x72/0x110
>    kill_anon_super+0x18/0x30
>    btrfs_kill_super+0x17/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0xa0
>    deactivate_super+0x40/0x50
>    cleanup_mnt+0x135/0x190
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x64/0xb0
>    __prepare_exit_to_usermode+0x1bc/0x1c0
>    __syscall_return_slowpath+0x47/0x230
>    do_syscall_64+0x64/0xb0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> The code:
>                 ASSERT(atomic_read(&block_group->count) =3D=3D 1);
>                 btrfs_put_block_group(block_group);
>=20
> [CAUSE]
> Obviously it's some btrfs_get_block_group() call doesn't get its put
> call.
>=20
> The offending btrfs_get_block_group() happens here:
>=20
>   void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>   {
>   	if (list_empty(&bg->bg_list)) {
>   		btrfs_get_block_group(bg);
> 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
>   	}
>   }
>=20
> So every call sites removing the block group from unused_bgs list shoul=
d
> reduce the ref count of that block group.
>=20
> However for async discard, it didn't follow the call convention:
>=20
>   void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info=
)
>   {
>   	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
>   				 bg_list) {
>   		list_del_init(&block_group->bg_list);
>   		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
>   	}
>   }
>=20
> And in btrfs_discard_queue_work(), it doesn't call
> btrfs_put_block_group() either.
>=20
> [FIX]
> Fix the problem by reducing the reference count when we grab the block
> group from unused_bgs list.
>=20
> Reported-by: Marcos Paulo de Souza <marcos@mpdesouza.com>

My bad, the reported by tag should use his awesome suse mail address.

David, would you please fix this at merge time?

Thanks,
Qu
> Fixes: 6e80d4f8c422 ("btrfs: handle empty block_group removal for async=
 discard")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/discard.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 5615320fa659..741c7e19c32f 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -619,6 +619,7 @@ void btrfs_discard_punt_unused_bgs_list(struct btrf=
s_fs_info *fs_info)
>  	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
>  				 bg_list) {
>  		list_del_init(&block_group->bg_list);
> +		btrfs_put_block_group(block_group);
>  		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
>  	}
>  	spin_unlock(&fs_info->unused_bgs_lock);
>=20


--LJhGpr9lnpkMF45A6cbrBPKBiJKhAuR2V--

--4kqRLThbir1yaVeQKpAT5QwgsfQQTQ7Vl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7/LDYACgkQwj2R86El
/qgy4wf5Ac4GwsiucCkAQ7qpeSb/gtWY2411IPdgo8g6bRZyYJkthBu8AEiTHJ69
RKrYNf3lF4v8Ya/jV0amWt3uP4G+SbD2mC5fWjzOHqSp4lYMKeyE/J9AiHXro5Wk
8yFvXuhnI+rgg2f5zhoL9OmAHaSAgvp8IYzVQ1EamYDS40oq4LDkPFj+/pT2T8mf
tR1Y6oPa+x2SSWqeVKk/HqFEa/VnRiXFloQkwkJQQPpa+MYslJ7weVK68Ypgoxyk
CoESnTgGYFMsHMxf+6TrXltnTZTMnFJW9z8rHZP2JghClkEx0zDyFaJcut3YfDvd
BgL6t2FEtW6shlOG7+B1R8OR3ZoMpw==
=AOjH
-----END PGP SIGNATURE-----

--4kqRLThbir1yaVeQKpAT5QwgsfQQTQ7Vl--

