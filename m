Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB162A2FBB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgKBQZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 11:25:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22174 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKBQZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 11:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604334303; x=1635870303;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ojabtIPnGdxsYUHRKl5jAXZ08n8eSBnZr3YME7cUuTU=;
  b=nZU4nSHwXuLwF6Rt8BX8lnT73040iT/7/bseo6EbMY/JtV8DT++6is4Z
   UFI6BEpc2dNwIZBdz24z5oNAqMOn7QWn6O9026jlRJW2SLK28E2AflpMh
   luGQEPVa3MFpihu3dgXRm3PKbc/q1V1zNzRsoy7kQPeNiYbM5pagFeN0Z
   f4IjKvbegTQrLU3z3fii3JACVnN0pl+sri1quz1dKfmF9DbUqSrfWPCwJ
   ca4CwWrCZ6XeFWub6LVvrLcC2DPnq1GRIG4+X3lQYDz4/fBjN5n3UO0cN
   rrGGk1Vp6ujKEtPTo0XGLIP4znKPyvoMrEr/E7il8QbbzR0cXYKrmF4Uw
   g==;
IronPort-SDR: GbyTrp9UpSHgE3f/YwuTNoiKG7hXc0tsDmxTKcTScXrFW84PYKfjgxNra3/qWkEXPY55qs4+GH
 ZlFizcivrcOH147UWUvQ2zaxPza7QpZdoKOtcYy1iYonJ+9U0PmLYuFzyDbroE+dkqD6D0BniF
 qJsVXJnLZpPlbAWm7VgbGnWYH/o8/K+Mh6BLPtf9Z9VW2jVsUqKsNu8OVnke5DjQ7Yrvl1JPwF
 j9027fshVPvhQqMiBQ1ZS9InKW3bgWiEYQBnPkK9qIlxbFx4VgjNgXacPrai1gbiI7vc9iI6Sp
 9pg=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="261508980"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 00:25:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae051bSljLLnDn8sxYWcy+Abhf0M7Kin46lP9GOLfUftluxpT9pqmf8v/f/VlWAnMY2Ed30Zc/pEC+y4pFD9NRDFI/YJQ9sKgpqndrxhrlNnL1ss6eaJyTUyIGzH9s3d4ZTAvhG17+Lg1pqhpZXG7ARJyehZBDLmOimv+Ow1CS4K+b8geCAkCeNATa9AXMuI/j4951LzTwkIARDIpeKUxlCfRnwvalnJWCYgL9izrG3yuYNqFwQQm75TsExABUMItHnqeTLnwDdX+qpDGSA1/aqabE0mA30ayC5AgXzmufYWymn0MVT20zjnfFlsAnEHkqs3JG/1obnYczp0t6MQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPono9ra/XEX0NiKV0RNQWx1Mi1GHhU2wFe6s6i/2aQ=;
 b=ciBJipxRT9NAKiBB4iBBAAJkP/HNs/7mBcc3lxgwRPSPIRvTb/pfhD8vcWpo49Gjeu8z/2JToldD14KnNEtBzuolrj2aAf36CT9CBQ3U5XnxaaWCDkyQj9cvZlE1Opc7SBagQvOPXIiOzTvT/Fz5eFIclxLLci0M9072/YT8uryJXyYpgmDWh46Uc58+MW5TyPnm/GgtRip9di0pjlreGqDFgrl26lBZfpcLeBgNYZeq+VGvlF9SObZ+jbA1DjhIMGq3/IHG2MCTR00YtKepZ+Xss06D+7a46mV1xfJznpI0/qnl0DYUG0I3Zdo9BLf5C9ExSWlFnGWi3BjBG1j3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPono9ra/XEX0NiKV0RNQWx1Mi1GHhU2wFe6s6i/2aQ=;
 b=NIV7FDaTUePVSWPHuIRT/XvTNuPDGrjXAGqbR4O6MY/bUcskz5rZoS96C+NrV2IXFaOu54yMvc9NnfIAzXqMJ8YwwIwj8oe2ailgg8K6eHpgBBd8C0oldbz5Ka4F4gOdhhRMDMpWOb176/gnHzJCOWLpLj30nUkxUx6OFMlKkCY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 16:25:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:25:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Thread-Topic: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Thread-Index: AQHWsSdWQbFcoF77nkenULWNz1I6BA==
Date:   Mon, 2 Nov 2020 16:25:01 +0000
Message-ID: <SN4PR0401MB3598625CBA6B556A7A3DCA029B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
 <SN4PR0401MB359899B411E936800C19F9419B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201102161056.GI6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cf05e1d-9a2b-4090-afab-08d87f4bd964
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB367807B1054A225392B5CC4B9B100@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/pKYZf1anGMx4jp8Ltad15cMnufKClYhPHyjv9XJ6a8pkJlvE07eAhG6EmceUZwp0a+90f4HymLdsRLRbMC6twd/UM65/yTvm1jaYwCZ2NvJ/aGuJvWJLShrZdIViQ5CgUZpJJKopR1il/E0jQMsNobT80fl5exH9IKFbeFgncLjUA/+hcnj3EdcpQsMr69p+NoIYigtBInuyMH719VEfHi7X7ofueB/2LuR2O9jpUo26C2+JjbVWLk+A9sPxUNQZTQTIFU4yPxVUSEksdZP9WAa+phryM8C0e1Bw8mPfx7U1n50wNMik3K/bim0bNmo6k0GqFK/W2SXpN3aPuvnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(83380400001)(6916009)(8676002)(316002)(478600001)(66446008)(64756008)(71200400001)(66476007)(66946007)(2906002)(76116006)(33656002)(91956017)(66556008)(7696005)(4326008)(53546011)(9686003)(6506007)(186003)(54906003)(8936002)(5660300002)(52536014)(86362001)(26005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +ptK++HgHpvW6+kJKoNKG1QI4iXL05aW1b7MwWx3fvo5+4gz61dpvsHH63X5EH9OdS9L+E5+Zm0nXgz1N0fm7Le4DN9kT40H6xaRbUtmjLVzSpDoRXpMtO9f48x1Qvb42tOJ0TfFz0kBVioi5NayyL4VmqmEl4FRyjoEhipKXZR7nbmusEgGFga7IIAujeR1KUGw/Hf2moEd2ZCAPPN+RhoJCJDey8buylOvCQypKWayCyPtWkpbxjegObkaAQzLpVvJ6vzZ7ADKozXbMecnLvKF92kXW7czrR4559ivIYNVPVLfAeYj3p1RhgqxJGw5HnIcVbg2KIM00q8y4xHiUU7+PF0GZaLNtWVM7VFaI7tQDVikjyVzEf3SqIl+9REXTda6az4lygstpZEO5vqo/zIES27aseXc5zMeZvUpGen3K3bThycQAudViHuDHQ5mQU5SAtCKo6C9Nk94TU8iCmVcsE2Z920TiCzkA7wpeg4SpUqSLn1fRtnyT5vWRTiTFAhJ6m9DWd7hMPOBegNXVTJio8tD4mk847mwl49scw5RnGD6cDWQC1aZM+ey4DHrcvyPj4Z+1goyA835nHNbXlitPK/eqZ5lkMPdxfk+0MABA3sLYnPorMzsnYNBTiq6/RaA7bIYsa+jL84Ysp4Z5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf05e1d-9a2b-4090-afab-08d87f4bd964
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:25:01.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUld9eFPpi7BolWpXKdUGKd97vO+SZ9XDoLNUlWtoZQ21QfcEJ9q+FTt/dPFC1Weg+tUAbwdILz0PuSPXP78jE3+QP8kVNHiEu/VP6MCQUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/11/2020 17:12, David Sterba wrote:=0A=
> On Mon, Nov 02, 2020 at 03:48:52PM +0000, Johannes Thumshirn wrote:=0A=
>> On 02/11/2020 15:49, Nikolay Borisov wrote:=0A=
>>> Here is another batch which  gets use closer to unified btrfs_inode vs =
inode=0A=
>>> usage in functions.=0A=
>>>=0A=
>>> Nikolay Borisov (14):=0A=
>>>   btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode=0A=
>>>   btrfs: Make insert_prealloc_file_extent take btrfs_inode=0A=
>>>   btrfs: Make btrfs_truncate_inode_items take btrfs_inode=0A=
>>>   btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric=0A=
>>>   btrfs: Make btrfs_delayed_update_inode take btrfs_inode=0A=
>>>   btrfs: Make btrfs_update_inode_item take btrfs_inode=0A=
>>>   btrfs: Make btrfs_update_inode take btrfs_inode=0A=
>>>   btrfs: Make maybe_insert_hole take btrfs_inode=0A=
>>>   btrfs: Make find_first_non_hole take btrfs_inode=0A=
>>>   btrfs: Make btrfs_insert_replace_extent take btrfs_inode=0A=
>>>   btrfs: Make btrfs_truncate_block take btrfs_inode=0A=
>>>   btrfs: Make btrfs_cont_expand take btrfs_inode=0A=
>>>   btrfs: Make btrfs_drop_extents take btrfs_inode=0A=
>>>   btrfs: Make btrfs_update_inode_fallback take btrfs_inode=0A=
>>>=0A=
>>>  fs/btrfs/block-group.c      |   2 +-=0A=
>>>  fs/btrfs/ctree.h            |  21 +--=0A=
>>>  fs/btrfs/delayed-inode.c    |  13 +-=0A=
>>>  fs/btrfs/delayed-inode.h    |   3 +-=0A=
>>>  fs/btrfs/file-item.c        |  18 +--=0A=
>>>  fs/btrfs/file.c             |  88 +++++++------=0A=
>>>  fs/btrfs/free-space-cache.c |   8 +-=0A=
>>>  fs/btrfs/inode-map.c        |   2 +-=0A=
>>>  fs/btrfs/inode.c            | 249 ++++++++++++++++++------------------=
=0A=
>>>  fs/btrfs/ioctl.c            |   6 +-=0A=
>>>  fs/btrfs/reflink.c          |   9 +-=0A=
>>>  fs/btrfs/transaction.c      |   3 +-=0A=
>>>  fs/btrfs/tree-log.c         |  24 ++--=0A=
>>>  fs/btrfs/xattr.c            |   4 +-=0A=
>>>  14 files changed, 233 insertions(+), 217 deletions(-)=0A=
>>>=0A=
>>> --=0A=
>>> 2.25.1=0A=
>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
>> Code wise this looks good to me. FYI patches 11/14 and 12/14 don't =0A=
>> apply cleanly on today's misc-next (at least for me).=0A=
> =0A=
> We're expecting conflicts, there are about 50+ patches in for-next where=
=0A=
> it could collide but I'd like to see what's the scope so I could=0A=
> better schedule the order.=0A=
> =0A=
=0A=
For 11:=0A=
=0A=
error: while searching for:=0A=
        unlock_extent_cached(io_tree, block_start, block_end, &cached_state=
);=0A=
=0A=
        if (only_release_metadata)=0A=
                set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,=0A=
                                block_end, EXTENT_NORESERVE, NULL, NULL,=0A=
                                          one NULL too much ~~^=0A=
                                GFP_NOFS);=0A=
=0A=
out_unlock:=0A=
        if (ret) {=0A=
                if (only_release_metadata)=0A=
                        btrfs_delalloc_release_metadata(BTRFS_I(inode),=0A=
                                        blocksize, true);=0A=
                else=0A=
                        btrfs_delalloc_release_space(BTRFS_I(inode), data_r=
eserved,=0A=
                                        block_start, blocksize, true);=0A=
        }=0A=
        btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);=0A=
        unlock_page(page);=0A=
        put_page(page);=0A=
out:=0A=
        if (only_release_metadata)=0A=
                btrfs_check_nocow_unlock(BTRFS_I(inode));=0A=
        extent_changeset_free(data_reserved);=0A=
        return ret;=0A=
}=0A=
=0A=
error: patch failed: fs/btrfs/inode.c:4601=0A=
Hunk #7 succeeded at 4763 (offset 70 lines).=0A=
Hunk #8 succeeded at 8428 (offset -68 lines).=0A=
Applied patch fs/btrfs/ctree.h cleanly.=0A=
Applied patch fs/btrfs/file.c cleanly.=0A=
Applying patch fs/btrfs/inode.c with 1 reject...=0A=
Hunk #1 applied cleanly.=0A=
Hunk #2 applied cleanly.=0A=
Hunk #3 applied cleanly.=0A=
Hunk #4 applied cleanly.=0A=
Hunk #5 applied cleanly.=0A=
Rejected hunk #6.=0A=
Hunk #7 applied cleanly.=0A=
Hunk #8 applied cleanly.=0A=
Patch failed at 0011 btrfs: Make btrfs_truncate_block take btrfs_inode=0A=
=0A=
For 12:=0A=
Hunk #1 succeeded at 3049 (offset 5 lines).=0A=
Checking patch fs/btrfs/file.c...=0A=
error: while searching for:=0A=
                /* Expand hole size to cover write data, preventing empty g=
ap */=0A=
                end_pos =3D round_up(pos + count,=0A=
                                   fs_info->sectorsize);=0A=
=0A=
No linebreak after the comma but a blank line in misc-next=0A=
=0A=
                err =3D btrfs_cont_expand(inode, oldsize, end_pos);=0A=
                if (err) {=0A=
                        inode_unlock(inode);=0A=
                        goto out;=0A=
=0A=
error: patch failed: fs/btrfs/file.c:1989=0A=
Hunk #2 succeeded at 3382 (offset 15 lines).=0A=
Checking patch fs/btrfs/inode.c...=0A=
Hunk #1 succeeded at 4742 (offset 69 lines).=0A=
Hunk #2 succeeded at 4762 (offset 69 lines).=0A=
Hunk #3 succeeded at 4787 (offset 69 lines).=0A=
Hunk #4 succeeded at 4822 (offset 69 lines).=0A=
Hunk #5 succeeded at 4876 (offset 69 lines).=0A=
Checking patch fs/btrfs/reflink.c...=0A=
Applied patch fs/btrfs/ctree.h cleanly.=0A=
Applying patch fs/btrfs/file.c with 1 reject...=0A=
Rejected hunk #1.=0A=
Hunk #2 applied cleanly.=0A=
Applied patch fs/btrfs/inode.c cleanly.=0A=
Applied patch fs/btrfs/reflink.c cleanly.=0A=
Patch failed at 0012 btrfs: Make btrfs_cont_expand take btrfs_inode=0A=
=0A=
Overall easy to fixup when applying or rebasing=0A=
