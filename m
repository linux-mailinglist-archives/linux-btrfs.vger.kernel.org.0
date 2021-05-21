Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0038C3BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhEUJsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 05:48:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19934 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhEUJsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621590410; x=1653126410;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yhscSLNMG7mOPk0ZTF6IvnTs1GwVkxV5kAFbk6ofsVs=;
  b=mXpezt1J7WYr5lnekHL9tdtwGUrBIe9ENSqTJ4JSkkIy0rRM6yddvGIG
   GHHI7evV4SEVgs812lQJdq4HuLhywdCH+H1wV/thJW6hw85EBm/d+PTwB
   ZefKr4Dirp9nNUJ2mVqI+Aotwt0t4du1eT91H7NfgqUtotJp50F3VXWPy
   /VBDsODZuXpS3MNzApo7vVFAY23zRCW7EfRH3KfKr+ei53NApzWlNzFtZ
   yqGmlnMhcB1YYyZr2bqiWMBRvWV7duE6iQww28wkT1KIbxGFxOB8Bw3dR
   6SkgV+NodSMfLOrIm3EMpVnVHdxW52VkU8kEY3KNWvY5ytnWzMml7JAdc
   w==;
IronPort-SDR: HgF2qv2WpLo7i18SUvc7LEcaZnC13tOPhfYC80QwwRe8PNTVXAn0B4hEtUknoI4qeomZGLjb6t
 qBHKyxuc70FXCsVAmVSDjHxvXkLUdO5/A4FjFi0kGIHuqDXyAIFqLJVf2xDv6P+Ko3r6f2UeeK
 HuEnGosMl9SLp5Zb48+J739r3qdj2gjb6G/Rj54CN7W/McrMXwh+5uuaz9f+vulBoQMPZkMoHY
 k3qosxf01oBmhZ3NmnpbqJIF96OOG+GEiNNWhGalYhBz3F07QH0hSKr8APAn/E+3N2UjTQMfQB
 c0M=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169522690"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 17:46:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4933q2ZE2MZiDHjaKodLlCsBwUUG4LlY/PGV7dXCZqdGYQTULvv41Xx6uUTWca8BnIxAC7cclh1UDAwnGXDV4e1CspWExvT9SIob3zy3nXpjWUkikrlbnHhka06/cwPQ5CLeL60ovowBRdWdKzHX3jbYF+zwqx5+e5Nq7MQXMb+QYoz6yURPcjR5VdD5r0XWWFz6m0Cr+C+vabRN+5FqZ2sYY8WODus9ezV4WtPBMKD3Q+fxW9N7U32pNOctMYW6FqXWnAlHwpLLyi6UhQT3vciZWleLC2stum98DIPGAXsGC7mVe62yzqeK0HluvOBLxXAI6DR485c8hauRJwGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+hzWbc4dvSvn5lzhEvgjXf92miFAUPMnYOPI4vnA/Y=;
 b=NrjgVX3RH0VQGmF+BtEw/q2DFrvyTIXi06bypgHc5e7reWbn2WFRkzrRuG0MZNBPzhPKTpEObtm8Cb/orwgAOkf7CaMLUTtIobsiZbanIzzMkoidFkFucVOQRKkGx5wIWRCelPdA4fNwQfH/8a3i3LO5oRmwc0JMSg/JEPbaFpPP0TNgt+PvY2hXM1eepBz37/+p40UFraI2YB+RQ7O9dVslKsF7ospo98f209YOFXGMoTMMCrWE1BsPKTAjunUOUlgIOjlFzEmfVZ+vtp6+DACEleU3PMmNYIND9dtNJem/hTyihkNRe7riq/3NLX0u4fRIHzLd4ggqlnEYwb6JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+hzWbc4dvSvn5lzhEvgjXf92miFAUPMnYOPI4vnA/Y=;
 b=kTdjbqimc9EKvPmFC6m71t+v6X40CRUiObG9LKCsPPqdOUX6DjUo34JQEIdrVWE5R//qnviiMhsSxQOh4kixQiwSa7PI8086FSX3TQFtbXtvYCWf5N6G7rKd33lumMnsg2LrNhiH+FaqxmkXRb1K1+UNwZNN0yaPKSyqYWFFfX4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6826.namprd04.prod.outlook.com (2603:10b6:5:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 09:46:47 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 09:46:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Topic: [PATCH] btrfs: zoned: limit ordered extent to zoned append size
Thread-Index: AQHXTiFEZpVXeDolGk269PbjlyQw+g==
Date:   Fri, 21 May 2021 09:46:46 +0000
Message-ID: <DM6PR04MB708120047EF5A0B1397C173BE7299@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <65f1b716324a06c5cad99f2737a8669899d4569f.1621588229.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1da4:199d:bd7:5694]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24abd226-8a6b-4cf5-07c5-08d91c3d599a
x-ms-traffictypediagnostic: DM6PR04MB6826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6826647803C241FBC7825F7BE7299@DM6PR04MB6826.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lr6XydzdQVnyw5pRZCSws+acO4br6X1yDgfUCKy74fyqdwvzdI0nVcEU7xHN0opjZe4nJWAek7y2Mf32D9f0fjL/Zl8lnKY99rrIqLFM33kYIOhAr0nIKl66GzfWx6J8pLeelR/ca5+3jRTGKrJRX5/uf49hdzCbrEeyFIkfZ5DYFOStsLa0dO9p1PFhRrsesYn0OJJJlrs9vWhFxSlu4hc3c37DtuHPaBLb5EVukoCqQgA5zFrKe+dyyUl36jl/hGUVH6iaR2fRxe4FoGognWuAHCz+NO1aHbXCqSh3hoPwhXP4H7vLkxT7nrKRzz76UGdOZ6jCJdem8n3fAQlK6EiCainowyEkk4YeXMu9VrXjAs2dbLNq+zbPuBnUsjGx8nwdfBS/KbCJPlykDDwLXkMFP4ch1reeRVf+TdWJDGZrO5T3dLBaDT+vbOFmPuaamkJAsz6vyAjt/xMKxSIAv7Txw9aMnpKBlbronH2+NOgp0d+N2JCAJzACDAOHNyb5bWVXNSUbFmu8x9YgBKFXU/6M/Eza2vVIYhc4sjyOWIkqZXqn+K3YAI/1TAzJxSOaPZNnX/tPSNV42aY1MCy7qUh2IVt6CbIJwavne/MRsps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(55016002)(9686003)(7696005)(6506007)(53546011)(4326008)(83380400001)(122000001)(478600001)(38100700002)(8676002)(110136005)(316002)(8936002)(54906003)(71200400001)(2906002)(5660300002)(91956017)(52536014)(64756008)(66946007)(76116006)(86362001)(186003)(66446008)(66556008)(66476007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uNh+6g0FKHSuXI8Rtdnl7snWT+kwP53V7GSAjH5yMtePzkNS3hMuN/d17q1VIrWXSvt6dgdpnbshvHLESRbCZYHQbSpwmsP85jfQwiBqOX83hFXcDLtwgiCu8BKjH8BcTg2IyW/rzgcSI82+qw6IvGEp8s1LGa8TMHnuX7JFe/m1eEKg2ql/eDqHModKxnqjkLTNkoMyqmvq/EH2ZKBqhubWElJv0XOVC/Mv4uqd7k18drDNKqV6JCmV8Ml8iGczeIg+cveDVcMXPB8QdJvRzPPT+9VltqUTtj/1onEX/6EZ8fcGXLlwFhR0fqIR2v6jXF5Evwg7YkaLfWnqdlGUIBivdorOs6EhYOi6qmxk6Y/T89++BFuRZByeVS3ZcxVEsmnu/YQ9lauCAyfmjP1AJl3/ChZKQ3mC+Voj5IiBiC2PdQ3z4QZbVVZVDqdI2phBBc/Dx5xyF8HPfcq6DX8s0fpaaNY2LXu9gEELHqbIaW9gxjE8x9/G9CuSYvV2flkisAphoqsFikUhwNbw5xm9aMEh/1styyLPekxoNdlS6sjP2d2oFYt8Zlwz1CtrFOgC+tgR/tdQlNfelUQselAFdmVQ1QE+lm/u0nBNEpdq4nLp6IGMXOfQcKqfTuPsqIbJTauGjKgmS+XggBQjIm9v/u+mAqlzETJ0xQ2ZxiFlX8UAVh3x0qHLz8mQOCAML5De1jkhsb87OrLizU0ofwmpimVQgSlDbr8FwZD5YLjhb0X0TPSCzz+mGfQjrZxYZfOnV/9E9NH+Y/QcvAFLLaBnuXU4pMBQHJOVUhwgOtDdK9UkXBRRZMqLndttlMM5A9c7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24abd226-8a6b-4cf5-07c5-08d91c3d599a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 09:46:46.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3KAZ7N9R7jDkw4TXR1nlSWkin7IcSLK8MbjL9mH3TqRksICVi6l9u9SbCGH6QXS0CBYMg998B7YzWDIrw3xSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6826
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/05/21 18:11, Johannes Thumshirn wrote:=0A=
> Damien reported a test failure with btrfs/209. The test itself ran fine,=
=0A=
> but the fsck run afterwards reported a corrupted filesystem.=0A=
> =0A=
> The filesystem corruption happens because we're splitting an extent and=
=0A=
> then writing the extent twice. We have to split the extent though, becaus=
e=0A=
> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.=0A=
> =0A=
> When dumping the extent tree, we can see two EXTENT_ITEMs at the same=0A=
> start address but different lengths.=0A=
> =0A=
> $ btrfs inspect dump-tree /dev/nullb1 -t extent=0A=
> ...=0A=
>    item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53=
=0A=
>            refs 1 gen 7 flags DATA=0A=
>            extent data backref root FS_TREE objectid 257 offset 786432 co=
unt 1=0A=
>    item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53=
=0A=
>            refs 1 gen 7 flags DATA=0A=
>            extent data backref root FS_TREE objectid 257 offset 786432 co=
unt 1=0A=
> =0A=
> On a zoned filesystem, limit the size of an ordered extent to the maximum=
=0A=
> size that can be issued as a single REQ_OP_ZONE_APPEND operation.=0A=
> =0A=
> Note: This patch breaks fstests btrfs/079, as it increases the number of=
=0A=
> on-disk extents from 80 to 83 per 10M write.=0A=
=0A=
Can this test case be fixed by calculating the number of extents that will =
be=0A=
written using sysfs zone_append_max_bytes ? That would avoid hard-coding a =
value=0A=
for the zoned case...=0A=
=0A=
> =0A=
> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/btrfs/extent_io.c | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index 78d3f2ec90e0..e823b2c74af5 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -1860,6 +1860,7 @@ noinline_for_stack bool find_lock_delalloc_range(st=
ruct inode *inode,=0A=
>  				    u64 *end)=0A=
>  {=0A=
>  	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;=0A=
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);=0A=
>  	u64 max_bytes =3D BTRFS_MAX_EXTENT_SIZE;=0A=
>  	u64 delalloc_start;=0A=
>  	u64 delalloc_end;=0A=
> @@ -1868,6 +1869,9 @@ noinline_for_stack bool find_lock_delalloc_range(st=
ruct inode *inode,=0A=
>  	int ret;=0A=
>  	int loops =3D 0;=0A=
>  =0A=
> +	if (fs_info && fs_info->max_zone_append_size)=0A=
> +		max_bytes =3D ALIGN_DOWN(fs_info->max_zone_append_size,=0A=
> +				       PAGE_SIZE);=0A=
>  again:=0A=
>  	/* step one, find a bunch of delalloc bytes starting at start */=0A=
>  	delalloc_start =3D *start;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
