Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0E33D36B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhCPLzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 07:55:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28407 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbhCPLyx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 07:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615895693; x=1647431693;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EpZJS1Qoi5StaN2UEijFhyCqvU2o3u6M9quAWxg17xk=;
  b=SOJs6GVxJ228m1c5jVOSevj5VbzZc9bg3A/FJWXSVTfuwrTgP7NrqR1Y
   Z5bS0/9Lw6tz0XiI/FyxXjmlSk47UfZKeym0VucfcpEYbK17M1fH3TfUG
   41+danWeBpwYvz6tJPAjKpzvlnSfhE7MZs6u6Z9e/hpjYzHCwT93ycwxU
   ZdjPNkvW2v6PcE/h+I4EcOOVb/QCqADewZyfdzeBkpdDDKnDa9PW2Zb7y
   39lnQZeb45FoXc2CPVywqkakaEYOZNDsYYg7+XSKrYARqHBccsgr36bfe
   Qitml4m8IKsvmmHdtKuF571Ci2F/Ywmt/hQgv4JIryIuCCcjekCTcASwL
   A==;
IronPort-SDR: ridSTwtvdJJ1BZgKIWCJYpFXVnxxSMBtcwVIq/3f5CP0Qvjes1bSmD1HTD6btPEQ1cT/YxCyS3
 9zl/gPEvM3h6uWOgD8gE2IBwVZ63o/jPybb+YTKACJqt8t51wxIA2zHsubBREOry+4B7xEiukO
 CrvPb38ZY4gIsPOWN/Zu5gVSokTnyhsJzv5GhQABJ9KVQywUfFTqzK+vBMgrNbesqZELMCqg10
 5b/thOlHg+96ahCWzjlBZGWMFOs/jBLmS22lvyzCdWsS77y/gjnYmzwHHmtaLhC6k+WiOAtGxh
 /2M=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272976390"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 19:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqADpuklzwCkdKWqaHJDVLa7AyNr15TSMVN/IRoAWY6w5AtVJac9uI3QLl1EymhoRF4Q9lRfRO98EBHuszCvI5tA6YKygVYYzb7I0iqzNHDdoTOKLGmDyRGnacGlj0zTTzefeOeIbAkAnXvLVC3COts3QQS9cAUZ7VzgCTkJqxpAF8QmNJ+JwMutMqoQcdSJGBK1842eyAUithczOnkupAUfxEAAaAKadoxzPdnAooVpWMw8b9kuG9h4jsqsqLrlEDcaRqkElbcgLXsQIfKoMFedmbhss9OaNPwmFKvW7xs6QTypHrJ/YYPAM4RB5c4MFN+dseNahTrQ34+JHUS/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8t94hOrVAc8A/7/TBgB2yAeW/IT2893zwwHGxGBJyY=;
 b=fpGIcbs2n1Y0MwmxQWNjfWU1QZRFcwvMEg452IlkdvbqEe5SApt+T/M7Q+3n9ekK0LMnsMP688OixSl1thUdrnmM+VB9t++tWGXwC3+Q4yRapBeO4KXCPi/rytCig0OgwpPaHN/rjgX2sIbeE24VS5KCx0mPhoCxUbgpyaHA06YEymV6FrdAwy6xS4TBeTJhraKK6I+6U2JeMZLc5VpxcE899g6USTek2pUf2QOQdDCVWyz8oSTysC7PFEaP8FAQEob3rCq6MGhKzUwYuDCMcLmrmwF1+/pJmwT1w+uAUT9qCBOu/QYmL9ZBpn5eu+RkCHU7Ao7WOnTHXEUp6ta+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8t94hOrVAc8A/7/TBgB2yAeW/IT2893zwwHGxGBJyY=;
 b=aOIA8FyMzZNh0RHDUpxOlt51QjV/zsK4hub9QuVQXTJjz07Gft7eYnq2UkrT0nuOTiPBkzcmnMUEmcl2FNLskD7hBbQYUvnA+Ue/n9BFFe25F1YfJWhe2JIQYU/CgWHOvfzK1xf4v1aoAAqS3gN/EXf9Z/y9oUPYj8pr7Uk6WiU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7510.namprd04.prod.outlook.com (2603:10b6:510:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 11:54:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 11:54:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/9] btrfs: always pin deleted leaves when there are
 active tree mod log users
Thread-Topic: [PATCH 2/9] btrfs: always pin deleted leaves when there are
 active tree mod log users
Thread-Index: AQHXFoNoojqJG9NohE6HjiRHBJDdDw==
Date:   Tue, 16 Mar 2021 11:54:51 +0000
Message-ID: <PH0PR04MB741620DDF31F7885B4E4C2DC9B6B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1615472583.git.fdmanana@suse.com>
 <d9d8cda5b3ab2a262d4d66e9fe8abd75912f252f.1615472583.git.fdmanana@suse.com>
 <20210315192857.GB7604@twin.jikos.cz>
 <CAL3q7H6XCJbz7=Q5=Kfy=NSJvqZP7bPuWSCZffFhfFw_kkJXSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:a4e0:11d7:79a0:82fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b08e697c-b90e-444f-24c0-08d8e8724e91
x-ms-traffictypediagnostic: PH0PR04MB7510:
x-microsoft-antispam-prvs: <PH0PR04MB7510A35555DE03A0AB92210B9B6B9@PH0PR04MB7510.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoMBTxchhpdlNIk3m8AoUCJSZQIrhi71d/T5Z+bSvbaju9NsEJPCVPQ1FC3M+d/OaK1XkIkMjaxsXyG6sCK6ZammRwQBNPbG3leoqvqnP9R+QpF0MsOlnHn0GemP0C1+PwZ3bjWrDjV0pRUH9Oz5HgmD7pD6qU0sXsCuIcDeB/hpkKqLVjdvYYgq73UCp6tqSP+/3tqgCq0n69SdtV0T74Oc7T6mkD3IMXFMDuBdZM8eMHhweOYNWjm6i8YADnr/xN3QBYBLtK+cJLdjnax556A+YZWhagyr7EDUpyX9KR+esmScoE7aVIbpND8iFeLqhwYFwFr7jDRsIFiZBFU8++YQN/UlG+X1Lw59vHl+KHW+qajnkmtNx/7vLItmvKsIgEoV6uMmyNna81XG0z7XxhekAHs9jAW585t9t70fS2Aktb5Yup17jR4EI7+FwD4bJNoOtDQxyuk9M5E6V3PBN7J4PNG2wP59QZcBcLEzdYI9/kedXtNGRB7m4a8SiYtDuWlL9QxXGoPOFxX0ttESYkIC52uKLPlU+VUwXcJEvMu4KsMweITz2z5OQ0pBBk0XxIxTdtDYX4ckvBxVdpemfJ9qkegn7SJGW2w3cJ2WhvC9psT8TBRVllf3s35DEJF2NaA7xECN1EOwhp/9GE7t9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(7696005)(478600001)(6506007)(9686003)(64756008)(33656002)(66446008)(8676002)(91956017)(53546011)(83380400001)(5660300002)(316002)(8936002)(186003)(2906002)(55016002)(86362001)(52536014)(76116006)(66556008)(110136005)(66476007)(71200400001)(66946007)(26730200005)(19860200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4uU9actU8+QGAzbn/EjDrG5BqCWobzSzDWSrZzTgsXkSAdcxD2Nfw0JVCtet?=
 =?us-ascii?Q?36zfMQ8DB68cQ3pRrLbcTWH2o1j+yGC7dq5U9UQU/mHRGJVnqch5dMEd1TYh?=
 =?us-ascii?Q?Id/b8ZYt8DT98Fd+1/JjpPCzn+xI1tCIWz0NTfLGUtoj7pYwOBrp5Qr36bEd?=
 =?us-ascii?Q?rrv3FBJ/15KUoj4Olt9pKadCrhK3NdmuHWkPYeOdWn7AuV/4BXhJ7n3NJhnb?=
 =?us-ascii?Q?UqaKG+VFhKYjmuFLm26qNIvVRhFrcq7DnAih814eTCw4Q4nzFxjYxtt2Avwb?=
 =?us-ascii?Q?gWtPo9JnuDPGXtNek8qUl3ESSS7m3nPY6O3IatFNT+yIdsDeGgjaPd/ub0LR?=
 =?us-ascii?Q?2meGboLB9CWcpzGfWKM+Q2CwiC6T5EkhxbPh1phfJZFtn1iA21yoS3100f5r?=
 =?us-ascii?Q?pUvdPh0OmFzSMqqNrcza8PcrCtnHcL3GHCCWa7xMItVtYk4jWu9R9gbt8Jnk?=
 =?us-ascii?Q?/Bdd5X1Kwban2qItqX13kYGJrvGE10L19qXaZ11pz1UD9KOmlHLonIund6lT?=
 =?us-ascii?Q?/tlsjADNXVMT+Dg7pCHtAzgOhRAJCsi6XeWkF3CZyVjc6RuD+6if62v9smT1?=
 =?us-ascii?Q?4OgmhyDNEwoj+zKFZsR3QODkrt7Era/kKQOaWs5dWQtheXVnP/aAHkFKOC1o?=
 =?us-ascii?Q?4WaC+15pl1ESlqM8B3iOvoz85VQS2j81ssXS5P71EIR2bXsp+eshq07Cw1Ub?=
 =?us-ascii?Q?c8wV09m+N55JPdAR3AxXB2hqZtHUrJ5+n0J8AiR2dy8h//gHu7w7bHwIXsU0?=
 =?us-ascii?Q?M3Fi3ZFeyVj12tPb1nxxVXYtFG4kjbrkcqWBSArtYKw9QukLYTvnRuyL/B0+?=
 =?us-ascii?Q?T+3Wrj0eQgrsg33NC/qWfT+MbAYbKQuISf6ZMetWv8I0IB4Fc6oXACKqGjet?=
 =?us-ascii?Q?lphLCdkskMqsEltd6u6+auqsfRLeQlMv6J/Z3sp+QWzJ5FIaba/uo0RvT4py?=
 =?us-ascii?Q?a9F/NAaG0ezg9EW22/kcQFudacWs9kdpzEJNKhS4yMbO2orU3DoCrOmLHUA1?=
 =?us-ascii?Q?v1GJ7ld0Py+EOCx4utU0WnyOfrdVauwe8gw8WBCUhCH7XmdlrU8vzHhjvcO+?=
 =?us-ascii?Q?KIhBH6KRME2gK66fw7ovpAIrNhoYqp7qV5BLvObptNdqaHciXWTQ9+Rupb/9?=
 =?us-ascii?Q?tTlEr6i8eUWfXVq7fVamDf2oDNHEdkLVxNvnHREzii36DsJPlMIr31RFx4mq?=
 =?us-ascii?Q?bLVpvCqn+vMcHDu1fTSHBCBmUHegRq+/DuOKk6LnqxJ1QS/4X37EpY2DPQJW?=
 =?us-ascii?Q?0UuGCPQjHqn8r9Fl6bdOjtYybCNhojL3UQPbEOL3lbKMA/OuWQefPYtY0Ijo?=
 =?us-ascii?Q?Jl3ZOgfaabvuMu4KUxc+25PC1KXusjgvg+dW7/aBogoHWi4ie8I8RwDPv0FK?=
 =?us-ascii?Q?Y1cwDL+4kN/g3fdeKinfTKO7sLjfSoDBNoBw1F0/XqDJTGHMMA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08e697c-b90e-444f-24c0-08d8e8724e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 11:54:51.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YtqgkfhVLJQmMQIHZHR8I/vrAXhlRnD9mJLl3X0Yimw3YYLrsae1V1bcg+YwIqaDgntePCubDVQoIwimfspxKf4Go96vbvv/wZ6j11Rw0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7510
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/03/2021 12:50, Filipe Manana wrote:=0A=
> On Mon, Mar 15, 2021 at 7:31 PM David Sterba <dsterba@suse.cz> wrote:=0A=
>>=0A=
>> On Thu, Mar 11, 2021 at 02:31:06PM +0000, fdmanana@kernel.org wrote:=0A=
>>> From: Filipe Manana <fdmanana@suse.com>=0A=
>>>=0A=
>>> When freeing a tree block we may end up adding its extent back to the=
=0A=
>>> free space cache/tree, as long as there are no more references for it,=
=0A=
>>> it was created in the current transaction and writeback for it never=0A=
>>> happened. This is generally fine, however when we have tree mod log=0A=
>>> operations it can result in inconsistent versions of a btree after=0A=
>>> unwinding extent buffers with the recorded tree mod log operations.=0A=
>>>=0A=
>>> This is because:=0A=
>>>=0A=
>>> * We only log operations for nodes (adding and removing key/pointers),=
=0A=
>>>   for leaves we don't do anything;=0A=
>>>=0A=
>>> * This means that we can log a MOD_LOG_KEY_REMOVE_WHILE_FREEING operati=
on=0A=
>>>   for a node that points to a leaf that was deleted;=0A=
>>>=0A=
>>> * Before we apply the logged operation to unwind a node, we can have=0A=
>>>   that leaf's extent allocated again, either as a node or as a leaf, an=
d=0A=
>>>   possibly for another btree. This is possible if the leaf was created =
in=0A=
>>>   the current transaction and writeback for it never started, in which=
=0A=
>>>   case btrfs_free_tree_block() returns its extent back to the free spac=
e=0A=
>>>   cache/tree;=0A=
>>>=0A=
>>> * Then, before applying the tree mod log operation, some task allocates=
=0A=
>>>   the metadata extent just freed before, and uses it either as a leaf o=
r=0A=
>>>   as a node for some btree (can be the same or another one, it does not=
=0A=
>>>   matter);=0A=
>>>=0A=
>>> * After applying the MOD_LOG_KEY_REMOVE_WHILE_FREEING operation we now=
=0A=
>>>   get the target node with an item pointing to the metadata extent that=
=0A=
>>>   now has content different from what it had before the leaf was delete=
d.=0A=
>>>   It might now belong to a different btree and be a node and not a leaf=
=0A=
>>>   anymore.=0A=
>>>=0A=
>>>   As a consequence, the results of searches after the unwinding can be=
=0A=
>>>   unpredictable and produce unexpected results.=0A=
>>>=0A=
>>> So make sure we pin extent buffers corresponding to leaves when there=
=0A=
>>> are tree mod log users.=0A=
>>>=0A=
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>=0A=
>>> ---=0A=
>>>  fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-=0A=
>>>  1 file changed, 22 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
>>> index 5e228d6ad63f..2482b26b1971 100644=0A=
>>> --- a/fs/btrfs/extent-tree.c=0A=
>>> +++ b/fs/btrfs/extent-tree.c=0A=
>>> @@ -3310,6 +3310,7 @@ void btrfs_free_tree_block(struct btrfs_trans_han=
dle *trans,=0A=
>>>=0A=
>>>       if (last_ref && btrfs_header_generation(buf) =3D=3D trans->transi=
d) {=0A=
>>>               struct btrfs_block_group *cache;=0A=
>>> +             bool must_pin =3D false;=0A=
>>>=0A=
>>>               if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)=
 {=0A=
>>>                       ret =3D check_ref_cleanup(trans, buf->start);=0A=
>>> @@ -3327,7 +3328,27 @@ void btrfs_free_tree_block(struct btrfs_trans_ha=
ndle *trans,=0A=
>>>                       goto out;=0A=
>>>               }=0A=
>>>=0A=
>>> -             if (btrfs_is_zoned(fs_info)) {=0A=
>>> +             /*=0A=
>>> +              * If this is a leaf and there are tree mod log users, we=
 may=0A=
>>> +              * have recorded mod log operations that point to this le=
af.=0A=
>>> +              * So we must make sure no one reuses this leaf's extent =
before=0A=
>>> +              * mod log operations are applied to a node, otherwise af=
ter=0A=
>>> +              * rewinding a node using the mod log operations we get a=
n=0A=
>>> +              * inconsistent btree, as the leaf's extent may now be us=
ed as=0A=
>>> +              * a node or leaf for another different btree.=0A=
>>> +              * We are safe from races here because at this point no o=
ther=0A=
>>> +              * node or root points to this extent buffer, so if after=
 this=0A=
>>> +              * check a new tree mod log user joins, it will not be ab=
le to=0A=
>>> +              * find a node pointing to this leaf and record operation=
s that=0A=
>>> +              * point to this leaf.=0A=
>>> +              */=0A=
>>> +             if (btrfs_header_level(buf) =3D=3D 0) {=0A=
>>> +                     read_lock(&fs_info->tree_mod_log_lock);=0A=
>>> +                     must_pin =3D !list_empty(&fs_info->tree_mod_seq_l=
ist);=0A=
>>> +                     read_unlock(&fs_info->tree_mod_log_lock);=0A=
>>> +             }=0A=
>>> +=0A=
>>> +             if (must_pin || btrfs_is_zoned(fs_info)) {=0A=
>>>                       btrfs_redirty_list_add(trans->transaction, buf);=
=0A=
>>>                       pin_down_extent(trans, cache, buf->start, buf->le=
n, 1);=0A=
>>>                       btrfs_put_block_group(cache);=0A=
>>=0A=
>> This has been added in d3575156f662 ("btrfs: zoned: redirty released=0A=
>> extent buffers") 5.12-rc1, so it is a regression but otherwise it sounds=
=0A=
>> like it's not related only to zoned mode. I'm not sure if this is=0A=
>> relevant for older stable trees because of missing=0A=
>> btrfs_redirty_list_add, possibly with some tweaks. Please let me know,=
=0A=
>> thanks.=0A=
> =0A=
> It's not related to zoned filesystems at all.=0A=
> I just happened to reuse that if branch for the zoned case because it=0A=
> does the same thing I needed to do, and the call to=0A=
> btrfs_redirty_list_add() does nothing for the non-zoned case, so it's=0A=
> safe.=0A=
> =0A=
> I.e., it's the same as adding the following instead:=0A=
> =0A=
> if (must_pin) {=0A=
>   pin_down_extent(trans, cache, buf->start, buf->len, 1);=0A=
>   btrfs_put_block_group(cache);=0A=
>   goto out;=0A=
> }=0A=
> =0A=
> I opted for the shorter version by ORing the two cases.=0A=
=0A=
FYI the redirtying is one thing we promised Josef to get rid in the zoned A=
SAP.=0A=
We just can't get it to work properly yet.=0A=
