Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D435E54F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347313AbhDMRsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 13:48:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49314 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbhDMRs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 13:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618336089; x=1649872089;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4vWS/G8zRuk9R8qgzBZDHomXK8tXjHiowkP36L7Rj6g=;
  b=UQxMspC9xIGfzCwz1WHXgjx6KyFOQPYyoszDBoQZOOTAa0VoVIl3mEel
   r5nH7kgLv0Lb4qYzPoQbymOblwtDEVQ6kxwJ1CS/IjtRiZANUZn4WyISF
   AAhxgl+Q9ZYvzoQxe299C5bFBlH52lH5cIg6rsgTvXt/kMl2oJVwMzqBe
   7wvN+t0o9Qw5af9QhMHKSCe8pfJ8aHL5/d55w4vSUityFMZ7AYy5smW0w
   kFXM1eUPMFNo4NymXnretnPIH8267XVf0zCjHRnlhZahENdiluB3e2IjW
   9v/prqQ30tcobyhqQwTLsqM50r69lIOKQZgSGI8r+VcMCciJSRSjbAMLE
   Q==;
IronPort-SDR: YcDf9mu9H7eDFp5dD2pxvGD4IEbspZFvqCH65lVi9alIGEek8BEgRu/yYK2dY/NN1BSK2iONHS
 XAj9y4+CLydK+M9iDPtu2yV/zCTGzUs37mbWUs8yPituhbZf8d76oxLECMG2T8s9KsqinoDDn7
 /RquWlr0dNGlKKO2No8T303ImI94vWVaeEJLdHetk3OmAvOwi+1CztQTDr+f3bFamkSeS1TYHJ
 +sVjl0IRZPJ+2cW5T13rMVAppFDHw9zfDdNZF/R252DgVDPbYrVjQs6IlxFEEAxhOmK3oDYh8a
 eIM=
X-IronPort-AV: E=Sophos;i="5.82,219,1613404800"; 
   d="scan'208";a="169166014"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 01:48:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHe38JttAyMzcx1YyOtIvXsdkIBl/AEVrcjd1OEmxjr+mXCbOpstB+ySjBSc6vBhtOJTAqM6QvDFbMXQeHOLltw9ewBuqx4MA+DC9JZfiqzJOVXSzohGB6XB5JzRYWHyHgUfuR5Gb0chM4EXOdHv4f2BJ1s7oPs+KdOKGpEyHKtOMuVZd4ya3/cdFzRDeMl8rAA27h7A4f9rliwuFT7ZeHdNRm65C68PHSUVu+uvJGbXLsnK/dQIlU9FepEYqqpOTmTPca3Kq4nt9Nr001T1xR0lij6XvKoVuab0h1w1Jt2xxSkkbBNDLmLP0aLmBPe9jYElCUgw9Z+QRggqa9UmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIIqdgX7p7o3jC+N3KgyzzseEPjx5XyL0gDECQ2V9zE=;
 b=gWD0ZWLLLINXMTRWysEfQaIdKAKSeOfvLdEzVg9nCRu7umoaxtuhZZgIVrvb9y8vgb/Cx7YLfWPYEsVm50bkAfH3ovRqaKR8GSTdysFfjmHfrZrOcGOdQWLJS76J+5qlFwdpC29yep0tUUsqdR8lNA+pMrFXBMOq+eYXwZttniFcxZdA/aqGQ+Af2k19r6QoUrwe1jB2fj6Cjqu3Q7Bnj6G9HWE/BY/oGoC5+uNIjJWNsIBWeO3FxVDnzwvd/S/tpObmG2BORkPLmO6XGSg4bmmKQBWtXiPHpIbs1TNSUjQK7adq6ptpz+310X+My8UO46Z23Vpp68ZtHfVr4HcWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIIqdgX7p7o3jC+N3KgyzzseEPjx5XyL0gDECQ2V9zE=;
 b=YlBgE5irQXTLLM3rfNzZzDnx2FTU0A732Ge+gpcTcKGeHiRPZcl1o65O9X/llCDVFGPgHdZE/2ki1JAxXCG1UyjOi2SiPZtqXEglkBVMzfsmIiRELCjJFZR4Q+nDecavFtn6SYWJdq+YWXMxXt6ETAW1/qYF8kPrqDDzLv33kdw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7413.namprd04.prod.outlook.com (2603:10b6:510:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 17:48:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:48:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Topic: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Index: AQHXLS6OQPw38ZTTm0ORPeiHMuNyDw==
Date:   Tue, 13 Apr 2021 17:48:06 +0000
Message-ID: <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a22010-d647-40c3-abf8-08d8fea44b30
x-ms-traffictypediagnostic: PH0PR04MB7413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74135CB75EE77B0FA264A8B89B4F9@PH0PR04MB7413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: laTaFazgrX0sWwbeZ9nOt5ZgWLxa/XWiDb9ckc/SbdO7l/BuUPq5ot0/sELb3/UHlfZiLhXmHNDWRYf3MWD8gVnOgQi6WuS8sysJvW+ECZ5ftq2hjcF5F8BU05x93R8U9Kegbgc2OZUsDV6zGq1F18JZZU2BiFDNG+C5mSpJ324Fi1zFuFrwfjFdEKBaQVN+Tqh5Lg5dnrlVTQBdi5ZuEyLRuz61ZgdjEmzdXrK84ONKeujgdiRsMnL1qNuTRFAk2lfSl9l7Yf3flvScm5M7+GyQ5Oo6kd/Q435EGnX3ms7MknWlmP1N55gfCJIFkgw7cGSnY8e7KEN7N5ngywH5XQRU+xaJVcNuYF+y88iFA3gxBCXx34eu7a04S4YIyyHYWJCx1HlYsDlyx7/C2prozRrbt93lD19ny6oakkNLlwnSt7sJDdFhwC8qXugxAdTLNTBJcT7fUqq/aIYNHPPq3tG5Hab5C1zaPodcX3J7QyzQMvkgQVXQKSJTPFFJwcOKS2SqKcp4lXq/CeFVP/OzNAneyoYKfD1GFmDUzCcZ9uGJziT6fqw433bMQsn8t16A3Y2vVQoAnrvyeq9YwVSwN0nYZee/0wbWN00Cb31QBXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(366004)(66446008)(8676002)(86362001)(66556008)(478600001)(9686003)(64756008)(66476007)(83380400001)(53546011)(66946007)(55016002)(71200400001)(316002)(4326008)(6506007)(6916009)(8936002)(122000001)(76116006)(33656002)(52536014)(5660300002)(186003)(26005)(91956017)(7696005)(54906003)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jUrLCZ6EkZ7rki0/0bvhrbfHNdD108aczTiyFNHtxt8VBLWSaThQL/W72AoE?=
 =?us-ascii?Q?l6jFFx6tV4yXsmy1d5KRRfuIkHHWtssbCWhRSkI0hoHg74J0lrcqbvSDhzo7?=
 =?us-ascii?Q?Ta87wiAzKBrzuWwCcv234d6EYebcJsBjzrpt5pEZJmkeB0FquaQH8PjcSn1I?=
 =?us-ascii?Q?lYWGY0vC24g9uKBAXqTM2PTpc4Vyu3RS0ERAI3EtH51JWP+EM+Dgbs4gfwPs?=
 =?us-ascii?Q?lsizy5olDLlIvqJZ9vZXdjz6Ntz6TOzC/roS106tV6F7ECsg9hVDv95EAcEr?=
 =?us-ascii?Q?1a0e9FnnXxbRIMaMUnQJ+xhF0Yju8mbkqDbihmTxBz0WfwsIrW+Ci8xKgfq7?=
 =?us-ascii?Q?OHfIwKMICgPHfA+UM/Vh/lq5bco8GUR5q5UvqvjAcSzFB1DfzYBQy2TOzkIB?=
 =?us-ascii?Q?dJPPFcOaPqv8WEG8Xq6540BExzykYtMSEYqja0s42XU2t3G0Zgus9JSRwItd?=
 =?us-ascii?Q?diZdfaVYDbaLUDrEH6Sq/D5hn1c9ZB0cai4DsnmCDGrgRYWi4NblJ2n8hTWu?=
 =?us-ascii?Q?rCT5T/JUZXJI0fnOCjh2+x+quKWQo6UH36SxnVxoiycmt4Wlmb5NFXpsyel+?=
 =?us-ascii?Q?6LQwTgojA4BpzJijPp/hgsUDop8Qlix36ig5kvNLVHJFztm595FzbbRjEk2F?=
 =?us-ascii?Q?iTWB8iwnO4MsDRHF1oQ5uVU4y7u86i57tvUM/+56UCz6fEmv4g3BTL3JlS/V?=
 =?us-ascii?Q?d90bPEbHZJ+OblR9aMAeFcOqOwvRQhuKjd2a/r7yhTA6fVJBxuDrHechsB7G?=
 =?us-ascii?Q?0rnpckj01WgNoORp0C+Zbd3AIyhrueFLeX+XEfYItm6wCR1GLKf25yaHnWHC?=
 =?us-ascii?Q?UFayd3KA3wSPBP76mJMf8aB/rRCI2N9W1N1CQelWaS5BoyzEB+/W/Fd9BPBP?=
 =?us-ascii?Q?lX8LUejG8LykuFWg9nDVHZmY3ZmuA3PMvmpxQDvMqzrpUVl76aL5ETPcrtZU?=
 =?us-ascii?Q?jM41qucNAjuSozP2PBO4/N1pgb6EUGYXGJtnw0irJZONA59XGO9VcZghifLr?=
 =?us-ascii?Q?iVzJkOZEdKTlkSPTRYTs65+1oIbUIS/Cxa4hmSxiib2XEpBEhtGN4hBnEvVl?=
 =?us-ascii?Q?+1yI1XmxgTmIYbq66sDSGIw//VFFN67RCwRzwqMJjs4K/efdXUy8H6FgBv/V?=
 =?us-ascii?Q?PhX17ZjF+DrZ6wgHqR/N1c2g/gVxhrnnjHyuHHsqrAfcdEX92Hafq5E8+woN?=
 =?us-ascii?Q?/A1di5mAAKvsaAOOuHAH9FomnpGWhLfkBfHD8im2dL21lvttfO48xfXweUSi?=
 =?us-ascii?Q?Yo8gRFbiml6DloWEmhSU2pm1CFJeVsYDejQcJmZyzkskHY2m+HjSP+FMguQ8?=
 =?us-ascii?Q?VSVjB4LDDiEQ88oT+txE0oa9JdiMU/lAuwbBvzAGNs9dfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a22010-d647-40c3-abf8-08d8fea44b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 17:48:06.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuDWiPdWkK4skwzHGV2Xr4hm/9PC38fNmi5SfwqrW3WHaaem8ZYQCbW2RjJjq+QUtOjoWXDmUYSd3SS8uU2S+jiTKDZr9gjTMI61i5TOMn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7413
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/04/2021 14:57, Filipe Manana wrote:=0A=
> And what about the other mechanism that triggers discards on pinned=0A=
> extents, after the transaction commits the super blocks?=0A=
> Why isn't that happening (with -o discard=3Dsync)? We create the delayed=
=0A=
> references to drop extents from the relocated block group, which=0A=
> results in pinning extents.=0A=
> This is the case that surprised me that it isn't working for you.=0A=
=0A=
I think this is the case. I would have expected to end up in this=0A=
part of btrfs_finish_extent_commit():=0A=
=0A=
                                              =0A=
        /*                                                                 =
      =0A=
         * Transaction is finished.  We don't need the lock anymore.  We   =
      =0A=
         * do need to clean up the block groups in case of a transaction   =
      =0A=
         * abort.                                                          =
      =0A=
         */                                                                =
      =0A=
        deleted_bgs =3D &trans->transaction->deleted_bgs;                  =
        =0A=
        list_for_each_entry_safe(block_group, tmp, deleted_bgs, bg_list) { =
      =0A=
                u64 trimmed =3D 0;                                         =
        =0A=
                                                                           =
      =0A=
                ret =3D -EROFS;                                            =
        =0A=
                if (!TRANS_ABORTED(trans))                                 =
      =0A=
                        ret =3D btrfs_discard_extent(fs_info,              =
        =0A=
                                                   block_group->start,     =
      =0A=
                                                   block_group->length,    =
      =0A=
                                                   &trimmed);              =
      =0A=
                                                                           =
      =0A=
                list_del_init(&block_group->bg_list);                      =
      =0A=
                btrfs_unfreeze_block_group(block_group);                   =
      =0A=
                btrfs_put_block_group(block_group);                        =
      =0A=
                                                                           =
      =0A=
                if (ret) {                                                 =
      =0A=
                        const char *errstr =3D btrfs_decode_error(ret);    =
        =0A=
                        btrfs_warn(fs_info,                                =
      =0A=
                           "discard failed while removing blockgroup: errno=
=3D%d %s",=0A=
                                   ret, errstr);                           =
      =0A=
                }                                                          =
      =0A=
        }                                    =0A=
=0A=
and the btrfs_discard_extent() over the whole block group would then trigge=
r a=0A=
REQ_OP_ZONE_RESET operation, resetting the device's zone.=0A=
=0A=
But as btrfs_delete_unused_bgs() doesn't add the block group to the =0A=
->deleted_bgs list, we're not reaching above code. I /think/ (i.e. verifica=
tion=0A=
pending) the -o discard=3Dsync case works for regular block devices, as eac=
h extent=0A=
is discarded on it's own, by this (also in btrfs_finish_extent_commit()):=
=0A=
=0A=
        while (!TRANS_ABORTED(trans)) {                                    =
      =0A=
                struct extent_state *cached_state =3D NULL;                =
        =0A=
                                                                           =
      =0A=
                mutex_lock(&fs_info->unused_bg_unpin_mutex);               =
      =0A=
                ret =3D find_first_extent_bit(unpin, 0, &start, &end,      =
        =0A=
                                            EXTENT_DIRTY, &cached_state);  =
      =0A=
                if (ret) {                                                 =
      =0A=
                        mutex_unlock(&fs_info->unused_bg_unpin_mutex);     =
      =0A=
                        break;                                             =
      =0A=
                }                                                          =
      =0A=
                                                                           =
      =0A=
                if (btrfs_test_opt(fs_info, DISCARD_SYNC))                 =
      =0A=
                        ret =3D btrfs_discard_extent(fs_info, start,       =
        =0A=
                                                   end + 1 - start, NULL); =
      =0A=
                                                                           =
      =0A=
                clear_extent_dirty(unpin, start, end, &cached_state);      =
      =0A=
                unpin_extent_range(fs_info, start, end, true);             =
      =0A=
                mutex_unlock(&fs_info->unused_bg_unpin_mutex);             =
      =0A=
                free_extent_state(cached_state);                           =
      =0A=
                cond_resched();                                            =
      =0A=
        }=0A=
=0A=
If this is the case, my patch will essentially discard the data twice, for =
a=0A=
non-zoned block device, which is certainly not ideal. So the correct fix wo=
uld=0A=
be to get the block group into the 'trans->transaction->deleted_bgs' list=
=0A=
after relocation, which would work if we wouldn't check for block_group->ro=
 in=0A=
btrfs_delete_unused_bgs(), but I suppose this check is there for a reason.=
=0A=
=0A=
How about changing the patch to the following:=0A=
=0A=
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
index 6d9b2369f17a..ba13b2ea3c6f 100644=0A=
--- a/fs/btrfs/volumes.c=0A=
+++ b/fs/btrfs/volumes.c=0A=
@@ -3103,6 +3103,9 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info =
*fs_info, u64 chunk_offset)=0A=
        struct btrfs_root *root =3D fs_info->chunk_root;=0A=
        struct btrfs_trans_handle *trans;=0A=
        struct btrfs_block_group *block_group;=0A=
+       u64 length;=0A=
        int ret;=0A=
 =0A=
        /*=0A=
@@ -3130,8 +3133,16 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info=
 *fs_info, u64 chunk_offset)=0A=
        if (!block_group)=0A=
                return -ENOENT;=0A=
        btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);=0A=
+       length =3D block_group->length;=0A=
        btrfs_put_block_group(block_group);=0A=
=0A=
+       /* =0A=
+        * For a zoned filesystem we need to discard/zone-reset here, as th=
e =0A=
+        * discard code won't discard the whole block-group, but only singl=
e=0A=
+        * extents.=0A=
+        */=0A=
+       if (btrfs_is_zoned(fs_info)) {=0A=
+               ret =3D btrfs_discard_extent(fs_info, chunk_offset, length,=
 NULL);=0A=
+               if (ret) /* Non working discard is not fatal */=0A=
+                       btrfs_warn(fs_info, "discarding chunk %llu failed",=
=0A=
+                                  chunk_offset);=0A=
+       }=0A=
+=0A=
        trans =3D btrfs_start_trans_remove_block_group(root->fs_info,=0A=
                                                     chunk_offset);=0A=
        if (IS_ERR(trans)) {=0A=
