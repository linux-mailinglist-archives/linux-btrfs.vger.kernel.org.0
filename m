Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B73F7096
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhHYHnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 03:43:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44169 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbhHYHnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 03:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629877365; x=1661413365;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ny+zIxzfxPwQqud+sVEpW2R4x9WDGC9AAFOlEaxaJms=;
  b=k3jooY3OQG6rCMrRlsp2X2EJNxlF1c5tmHRjgFlYTDB2UKvII0OWsyv1
   VWy2v2iu5SzScy0voqS07LK3hLPW3fDxpXOOXgFbZx5o+zyoLqKFZiqfT
   Olr287A/N7TKrlvfKUa/FfejX17qcAQ/3N2/m93/Wzae0wo0DTt2/zmUn
   nVvju2500/t1vYPpn6OwuJkIpn1FBs61SYmYMUTkfumpKO7FDqJBS1gLq
   ksX1mH4YxPlSZU5S9Qo/Qmu5+8M0nSlT1H4s9T9NXk+YuhWoSi51fFC1A
   N7/DddzizB8b8oq/EAKWhwPvtg6ajJY4dfoBHRfmUnBPMPG2F98CtOjnT
   g==;
X-IronPort-AV: E=Sophos;i="5.84,349,1620662400"; 
   d="scan'208";a="289920468"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 15:42:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZo2x66lfgKeWAl8Z4vxvRDJEnspRmOi3B7iGEfVEl3LM/232WYnA5uCcacI36DKyBjYhExZKALgZYQ5fQ02clp3X/MC/b3whn6xYp6OLJdTOHVAQ8B3GHZves74P11QcLc8p1rSd8ZFAQxRnBXLh/4wx4gk4BGEBRVlEeBPpwgFHcTaB3K4JMMn8qKdE8uL+8bSpSC0HngydlZMSQqR7/4rIvTfQMrghnEkbd/4n0hRfFTGZNHHK3Pv7XgLrJ83sOipiFVvY8NN2IRiUhU0cRD0kMq0+/GA6WUPB7wbsezLRI5pigyEStpvAbJ3W2b3AwGnBqXVtIMX0tWEzLBEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP2gGL7mOse6Qb7zPFYivI/WYIrFh/D4M0xVG5uMDHk=;
 b=kJ6HELD9CTYTZEWhPhdWdHMTIFOQFUS9Rlor9xsxtZ+WPlW9QGd8te+lQ1pyJeBgIkEOizwHzRX9/aKeMKdNsF7fypkja3pkuv+yb4FNTC7WcS1B2RpbjZw47ZaKsLDMdMi7uee8SmAP3/orsYuAy0ileha83W43CsE0dVKtyvZGVG0VAgX0xa6Ry1JPtCIfUGgoung/j1FhXtIR+Jo/4nUkA5cSXNCOaj2WAB6hc2sLJn1OUJefAJaq7lIK+SeYOLkcLv8oZBhjZlSJZge+aYHfNy1tG0jmGfKbz5JhI/ZC+en3DZ9oH/m3V1Yik7YEJB8vacsFi0jtCQg2CB3WOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP2gGL7mOse6Qb7zPFYivI/WYIrFh/D4M0xVG5uMDHk=;
 b=uOEMCXRk0RV02CxFm9m+XpONknqpiHZPiMNeuOa3dgkmf/HOHWdH7x44G3YCipqFBqZyNZ6MZGS7/9mYEGjFs66mIJ3jQXfvDFP1brjUEj4JrNC1kY9iH4MeNQhg1yk01S5FP96pGQ1Aom+GGSsOnojfKlbVa0VAZlRXuH/0s8A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7174.namprd04.prod.outlook.com (2603:10b6:510:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 07:42:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 07:42:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 1/7] fs: btrfs: Introduce btrfs_for_each_slot
Thread-Topic: [PATCH 1/7] fs: btrfs: Introduce btrfs_for_each_slot
Thread-Index: AQHXmQtPAnq46P8J2EG4j6jXf1CXnA==
Date:   Wed, 25 Aug 2021 07:42:43 +0000
Message-ID: <PH0PR04MB74165AAE8DA3D7BA81C2A0AC9BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210824170658.12567-1-mpdesouza@suse.com>
 <20210824170658.12567-2-mpdesouza@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d9b388-6480-4336-7775-08d9679becbf
x-ms-traffictypediagnostic: PH0PR04MB7174:
x-microsoft-antispam-prvs: <PH0PR04MB7174341E70B0CB4B71BDCC219BC69@PH0PR04MB7174.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suvskkjaVt1a6GhDzORqKulSElcaQwMXZsaCrRCMInGDDNNkQ+ULi6TRGeA4DMBhO6etvGN0m7TvVZ4DKDp/Kp7VNyubx45Fz1gh8J6Fpg9bK1vHgzCxZYaCsCxiz3CmUVM55kd/XudiYn3CDSDkEHyG00+TO61qZ9owUKkbgz2f2wbL7yLMw3VyPSEn1r4DJ/Ub0GA/WjFekKLSuxSyemlsoy7ANqYhw+A3RNKw3JRghEi4+KuWB2h444R2Xgiyl9amOAl53fieO+vi8YIcuM7AbpT1O9pTf9L1yIW33a/2CNagsoOZSzR5emvsIRu1AI2hly4G0miwNJSaasDBK/pw47VPJPRcRTpPonq1m09A+l8dQJVjoKHcd1bGC0cKEL8c9oYuJAhG11fuErG7uCxyhRFMq03U2/h0IU/DHnn/ns38y2TLzRKWlLxhc+F+wIYpsJ+bMimGD2N/0B1j4FwaDlp7gQQ/ygsuEnjqdWJ1Wm21Nf6fGerTvPxJpgBxoj/xzM5uLImwwVLVZ/YZsG5bhs2aRAuEa+lIOqnVxWszU/c5LEIlBR0s0eWfIe9kjTLHwnO6CdfFe4smWXF8atOAI02SbklesQ1hfNXl+OFvx0ExZncUEdJH7K930yR4ozer5EFlTiNJkxxjjUndz9EpJdKzeAKEG33GmNWeHfEqx7QdqV2vhXWE+HYdSHpTokN10AdZv/QCA0Alq9L4WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(54906003)(66946007)(66446008)(53546011)(5660300002)(66556008)(52536014)(316002)(4326008)(8936002)(55016002)(91956017)(71200400001)(8676002)(110136005)(38100700002)(122000001)(2906002)(86362001)(33656002)(83380400001)(66476007)(478600001)(186003)(9686003)(6506007)(7696005)(76116006)(38070700005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tx6m7RbgjioMicHN408AeDFp/Bp+cxXO4+vw17pIHh/ashFiL9YH8us4VCxp?=
 =?us-ascii?Q?N8QijQiqgKXBPwF0RLXT+KlqKz3o87m4+XWB6yvYYM/jNKW03dexHPZA07wA?=
 =?us-ascii?Q?r9cjluv2ncLyHbRVIlYBPnRdLzLC668qo+9zrZWvw4vbTYMRq8FPn0xcBlQc?=
 =?us-ascii?Q?oePR/SpooabCDwHk2GO7c00rzHcdNzGq8U4VtwaD90vnoGa27F+0m1I4Khkv?=
 =?us-ascii?Q?6e3eeKhY0GJY/TpC/y3t6CBYww/PgBcJ9lYJpiqB0zXPsNGg/3JzwOFpw3gz?=
 =?us-ascii?Q?bh9LzCX31yLICuMUQKKq1Rz2da6KUR+KfLJQsZXwX7oa0/N4qvpbAFOFRcXA?=
 =?us-ascii?Q?OnGaFQehJrJ3ZLxNmo0O9N3oJffwO7UxEOXSsLmLW4GZWQIeZ4uMv70jIl6E?=
 =?us-ascii?Q?EXDMD4lzcS11rxenRCsoOAdywGURG11DopM7QH7MyyeNzcfjGz5sD2NE65+N?=
 =?us-ascii?Q?Lt8k5oGcm8/ALGD7wzyup1R1ShkWMNACXSmq6+LY7rQoJUbyUX9K2bVrIlIa?=
 =?us-ascii?Q?6hZV0kgTPRpWa6abh/muWUMSX9JMnTo5mDKL3DvGDA5m0Qd2w4WgFPSLvb7F?=
 =?us-ascii?Q?nGnJfmsu4XnuscyI7GRnPxuvpoN7a3e+sbnEUCsU472IJU6QEsnwFBMJlZMH?=
 =?us-ascii?Q?EEt5YyQEZ6wRApUf/PEktZ9LPqo6zl1FCSAoCGinKk8PrLv549Djew126TN1?=
 =?us-ascii?Q?JsuewK1PW/ZXdP9W2/3YavSTxCi8vgPLwD817cPGFotjGEWpGbErBIONMIiT?=
 =?us-ascii?Q?eTIuEVElQqytOoJFQwWdIahrizppqylDX1GOpXmugGBoHW5dk/xJsF/S2Zw0?=
 =?us-ascii?Q?RjP+aJxBwk9lO8ZNnJODyPvlwkYCfvrsiHLJXWiN51F/kTZ5N0Jd0ByadziA?=
 =?us-ascii?Q?26Hnr67fETpWKKsKcVhHJYE6yraKcCsV/46VUqBIkgNPkQyT8wlzmWT0R9h5?=
 =?us-ascii?Q?SF0xdoNWzloOo4J0X32Bgx/we3NcKwJuBl+Feu/sEfO+/dhoMQZVWpZiaOX8?=
 =?us-ascii?Q?wDcMs92ML2YCDdSrz/L9i4FSOBZ7mdbWEtRAx41khWcmNPXt9LfzEjOfZNL7?=
 =?us-ascii?Q?FgFlD03fZE2b6+JHuZTPzSEdPxXshkaglh+65IQDzq8NJXwHmuWw0uon7Soq?=
 =?us-ascii?Q?zdHpCMs5fMwrmvlituGQKyPoY2mW6PGNV0M6GXv+vJfmBut1vXkdhEjStRiB?=
 =?us-ascii?Q?n33upPdDvDpthbp4gLlDnLoPcLOGwIzwHFgpLnuJEixdQWEFc4oC1wqju8el?=
 =?us-ascii?Q?s4uqpJAqzIlCHZ+JvF8sloyj98P9CV4InKM6BnduMGyzTU53W8pCGJ8pSxij?=
 =?us-ascii?Q?Za3rHefB0w/zFUgFVXKRtKYNr07gAn4cF6jNdzqjr1ppO3+HJqA+QHd4yDYx?=
 =?us-ascii?Q?SxvAHfq4itJacC5gWkzgL8ofCxzAcotGDlS36TXKj+q7KlxZJA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d9b388-6480-4336-7775-08d9679becbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 07:42:43.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjKM5wmGqc+vBgV7DbWwpCFQi+2Ukjkj2wHzabkGyefZx/yQV0fcHPEbWeLoCZmsHemt1DvLYbqC1SX/p+9JGIR20F1VVQE1O47baYJwztA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7174
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/08/2021 19:13, Marcos Paulo de Souza wrote:=0A=
> There is a common pattern when search for a key in btrfs:=0A=
> =0A=
>  * Call btrfs_search_slot=0A=
>  * Endless loop=0A=
> 	 * If the found slot is bigger than the current items in the leaf, check=
 the=0A=
> 	   next one=0A=
> 	 * If still not found in the next leaf, return 1=0A=
> 	 * Do something with the code=0A=
> 	 * Increment current slot, and continue=0A=
> =0A=
> This pattern can be improved by creating an iterator macro, similar to=0A=
> those for_each_X already existing in the linux kernel. Using this=0A=
> approach means to reduce significantly boilerplate code, along making it=
=0A=
> easier to newcomers to understand how to code works.=0A=
> =0A=
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>=0A=
> ---=0A=
>  fs/btrfs/ctree.c | 28 ++++++++++++++++++++++++++++=0A=
>  fs/btrfs/ctree.h | 25 +++++++++++++++++++++++++=0A=
>  fs/btrfs/xattr.c | 40 ++++++++++++----------------------------=0A=
>  3 files changed, 65 insertions(+), 28 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c=0A=
> index 84627cbd5b5b..b1aa6e3987d0 100644=0A=
> --- a/fs/btrfs/ctree.c=0A=
> +++ b/fs/btrfs/ctree.c=0A=
> @@ -2122,6 +2122,34 @@ int btrfs_search_backwards(struct btrfs_root *root=
, struct btrfs_key *key,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/* Search for a valid slot for the given path.=0A=
> + * @root: The root node of the tree.=0A=
> + * @key: Will contain a valid item if found.=0A=
> + * @path: The start point to validate the slot.=0A=
> + *=0A=
> + * Return 0 if the item is valid, 1 if not found and < 0 if error.=0A=
> + */=0A=
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,=0A=
> +		     struct btrfs_path *path)=0A=
> +{=0A=
> +	while (1) {=0A=
> +		int ret;=0A=
> +		const int slot =3D path->slots[0];=0A=
> +		const struct extent_buffer *leaf =3D path->nodes[0];=0A=
> +=0A=
> +		if (slot >=3D btrfs_header_nritems(leaf)) {=0A=
> +			ret =3D btrfs_next_leaf(root, path);=0A=
> +			if (ret)=0A=
> +				return ret;=0A=
> +			continue;=0A=
> +		}=0A=
> +		btrfs_item_key_to_cpu(leaf, key, slot);=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * adjust the pointers going up the tree, starting at level=0A=
>   * making sure the right key of each node is points to 'key'.=0A=
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
> index f07c82fafa04..1e3c4a7741ca 100644=0A=
> --- a/fs/btrfs/ctree.h=0A=
> +++ b/fs/btrfs/ctree.h=0A=
> @@ -2912,6 +2912,31 @@ int btrfs_next_old_leaf(struct btrfs_root *root, s=
truct btrfs_path *path,=0A=
>  int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *ke=
y,=0A=
>  			   struct btrfs_path *path);=0A=
>  =0A=
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,=0A=
> +		     struct btrfs_path *path);=0A=
> +=0A=
> +/* Search in @root for a given @key, and store the slot found in @found_=
key.=0A=
> + * @root: The root node of the tree.=0A=
> + * @key: The key we are looking for.=0A=
> + * @found_key: Will hold the found item.=0A=
> + * @path: Holds the current slot/leaf.=0A=
> + * @iter_ret: Contains the returned value from btrfs_search_slot and=0A=
> + *            btrfs_valid_slot, whatever is executed later.=0A=
> + *=0A=
> + * The iter_ret is an output variable that will contain the result of th=
e=0A=
> + * btrfs_search_slot if it returns an error, or the value returned from=
=0A=
> + * btrfs_valid_slot otherwise. The return value can be 0 if the somethin=
g was=0A=
> + * found, 1 if there weren't bigger leaves, and <0 if error.=0A=
> + */=0A=
> +#define btrfs_for_each_slot(root, key, found_key, path, iter_ret)		\=0A=
> +	for (iter_ret =3D btrfs_search_slot(NULL, root, key, path, 0, 0);		\=0A=
> +		(								\=0A=
> +			iter_ret >=3D 0 &&					\=0A=
> +			(iter_ret =3D btrfs_valid_slot(root, found_key, path)) =3D=3D 0 \=0A=
> +		);								  \=0A=
> +		path->slots[0]++						  \=0A=
> +	)=0A=
> +=0A=
>  static inline int btrfs_next_old_item(struct btrfs_root *root,=0A=
>  				      struct btrfs_path *p, u64 time_seq)=0A=
>  {=0A=
=0A=
Shouldn't below xattr code be in a separate patch? Just like the block-grou=
p,=0A=
dev-replace, etc changes?=0A=
=0A=
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c=0A=
> index 8a4514283a4b..f85febba1891 100644=0A=
> --- a/fs/btrfs/xattr.c=0A=
> +++ b/fs/btrfs/xattr.c=0A=
> @@ -274,10 +274,12 @@ int btrfs_setxattr_trans(struct inode *inode, const=
 char *name,=0A=
>  ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size=
)=0A=
>  {=0A=
>  	struct btrfs_key key;=0A=
> +	struct btrfs_key found_key;=0A=
>  	struct inode *inode =3D d_inode(dentry);=0A=
>  	struct btrfs_root *root =3D BTRFS_I(inode)->root;=0A=
>  	struct btrfs_path *path;=0A=
>  	int ret =3D 0;=0A=
> +	int iter_ret =3D 0;=0A=
>  	size_t total_size =3D 0, size_left =3D size;=0A=
>  =0A=
>  	/*=0A=
> @@ -295,44 +297,22 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char=
 *buffer, size_t size)=0A=
>  	path->reada =3D READA_FORWARD;=0A=
>  =0A=
>  	/* search for our xattrs */=0A=
> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);=0A=
> -	if (ret < 0)=0A=
> -		goto err;=0A=
> -=0A=
> -	while (1) {=0A=
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {=0A=
>  		struct extent_buffer *leaf;=0A=
>  		int slot;=0A=
>  		struct btrfs_dir_item *di;=0A=
> -		struct btrfs_key found_key;=0A=
>  		u32 item_size;=0A=
>  		u32 cur;=0A=
>  =0A=
>  		leaf =3D path->nodes[0];=0A=
>  		slot =3D path->slots[0];=0A=
>  =0A=
> -		/* this is where we start walking through the path */=0A=
> -		if (slot >=3D btrfs_header_nritems(leaf)) {=0A=
> -			/*=0A=
> -			 * if we've reached the last slot in this leaf we need=0A=
> -			 * to go to the next leaf and reset everything=0A=
> -			 */=0A=
> -			ret =3D btrfs_next_leaf(root, path);=0A=
> -			if (ret < 0)=0A=
> -				goto err;=0A=
> -			else if (ret > 0)=0A=
> -				break;=0A=
> -			continue;=0A=
> -		}=0A=
> -=0A=
> -		btrfs_item_key_to_cpu(leaf, &found_key, slot);=0A=
> -=0A=
>  		/* check to make sure this item is what we want */=0A=
> -		if (found_key.objectid !=3D key.objectid)=0A=
> -			break;=0A=
> -		if (found_key.type > BTRFS_XATTR_ITEM_KEY)=0A=
> +		if (found_key.objectid !=3D key.objectid ||=0A=
> +		    found_key.type > BTRFS_XATTR_ITEM_KEY)=0A=
>  			break;=0A=
>  		if (found_key.type < BTRFS_XATTR_ITEM_KEY)=0A=
> -			goto next_item;=0A=
> +			continue;=0A=
>  =0A=
>  		di =3D btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);=0A=
>  		item_size =3D btrfs_item_size_nr(leaf, slot);=0A=
> @@ -365,9 +345,13 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char =
*buffer, size_t size)=0A=
>  			cur +=3D this_len;=0A=
>  			di =3D (struct btrfs_dir_item *)((char *)di + this_len);=0A=
>  		}=0A=
> -next_item:=0A=
> -		path->slots[0]++;=0A=
>  	}=0A=
> +=0A=
> +	if (iter_ret < 0) {=0A=
> +		ret =3D iter_ret;=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
>  	ret =3D total_size;=0A=
>  =0A=
>  err:=0A=
> =0A=
=0A=
