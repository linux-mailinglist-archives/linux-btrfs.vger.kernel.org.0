Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE96349BBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCYVj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 17:39:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:65515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCYVja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 17:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616708370; x=1648244370;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gfJkws7b3uKKDFRU64ijcw6Ms7s5RMPiwnJ4Q/mDUiE=;
  b=RImKn897Qi9RBwrBsWD7gNFqjOVoe+T2WKR3CiULivJ2YbL/HN36EVy9
   WOd5YLp6Kahko5t8x1e3YRsMOGKdyfZWZl2UUt1Cn5HI4aN33kbf43dqe
   lDyCIrA4UV0++FBfxbWREWgDqZn+mUl22gbQLh1B07ZP3MsTahG4XXjff
   zyibYY1LoN84bKrcIEklxwQnoOMZsK7uxmYLScxxIW+HhAHiRvaEMNt9v
   YI8jN251bdDDP2RfYYP6e0pop5e6U4tXC7H++//xwpQFxeoxkevp4h0Qx
   YImtRJ4y7tGFa0g1s1ykDj9bo89d/GyH0BTkfqOtxGUueyMAjyZC4ClQR
   w==;
IronPort-SDR: xR07CbwZDYkQMhy1GjylGt+fctuI3TIXlXrRMZ1XR+XXwh/7tg9Gm/rfNC7K593txoX+IokOFw
 NvaDoe5LwFPg53V6qE68oa/4uRm9kr9D00KMghGHMYIUI/E1FYUFilp7KuwXkwU7UxuGOdZTD6
 Njynx+mwEAwlfmE7rDWI61SGNgiB6PVtWalQPNMiVpLGMO8+WngnWePXzrF+iO0J3iIQ73AHNv
 rg/LU9rTwGz8b5AiLVxS1SN0oUUfCuajv2Je/HT7uVtvIJTuneNWMlSbCaLczIfqjBBkGGqn6F
 D1Q=
X-IronPort-AV: E=Sophos;i="5.81,278,1610380800"; 
   d="scan'208";a="164136259"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 05:39:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpLA3pOHIg889MMAwnAtVrKhX1M2V1Jc/y4rxAi86JNNwd401wpAJORh+ABxGObT4HqvapGsFb+0RzKl19S/pcpYqZvIHUjDs7TsTNqLeL8xAH7rEJ2KjowzSt86DjXjcwukbzKNblU688rhAy/x6c454nedHZfD/68r+Lek1OxxDfVA01rL/IyjBgtlxfvLLtV6OEFp/YtRFl90CvUBxV1zXBfx4zv4o0nxd47wEQ91K34l5Mprnyi8wFr7H2UqW2r4gV3BLKrYdQimhFIsf8sryvLZahQ0jR+a0I6svW72XIfIeYbdlIrnhZevPEHhDaM+E6bw1z9NOKw23ku/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbeQMwfXSZIZUdN3kMtX0IVos07G5YtHk6ctxpmI0X0=;
 b=eXM88TparzMUBgXLobgYw2U8qRbQjDDi2wSY+lorjx60pVAShdH/pD+JNolYm64lutt5hcKNTyTg+UHIlUaY8lkRZzLOE21CZ1N2fz/oPBqR/se18YldzTWxZi7XsY2JlxEibPwJ4n2CVjmbflEcddMZQUAGVjF7kw9BC8EUhaNOxelpDH/+PiyFF19OVDHm8b7NUr8ROP0SVIxhFtSQOPCEG9CWUdq9zPEyXW+rAS3oHujhLgPjFjp96VAFIMuDN5jT4UiI9oF7TFe4+lLgA2hcK/x1FgITAP4/vbnVUUO7ZlyLDMAomnthkXCI534MeUaFrJA5/Zu1sCNukyNzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbeQMwfXSZIZUdN3kMtX0IVos07G5YtHk6ctxpmI0X0=;
 b=i0mmZOx3VZQux5eWiVfFSp4kr18rMBsO9Y9xqq3els69DH7B5P43YG3KYTHqfDUXjsenGLU5gz9nNW6eGNnu28BCspWKrPTy2TJmmM30PpJEzthszxb0D9SLi+z5ZaGctmlc/Oy4igEwhSrXuR5LZJ90k+exmveSSHoJB4w050Y=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5089.namprd04.prod.outlook.com (2603:10b6:208:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 21:39:28 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 21:39:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: don't relay on /proc/partitions for device size
Thread-Topic: [PATCH] fstests: don't relay on /proc/partitions for device size
Thread-Index: AQHXIWmVqDYy4PjZs02Ok/wS8o+NMg==
Date:   Thu, 25 Mar 2021 21:39:27 +0000
Message-ID: <BL0PR04MB65148BE9D5E4B24B68095F53E7629@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210325112337.35102-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2c1b:956d:a4c2:114c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94602e88-ce7e-4162-0693-08d8efd6778a
x-ms-traffictypediagnostic: BL0PR04MB5089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB50897EBF839C050FA5233F1CE7629@BL0PR04MB5089.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XeT3ksW6xa0+4EIy8CjNzOcsBz/3p/5D2ZtVoHtvWX7crXAgUu4+yYGYKEfQqd7MrOWqrn5JsUKpvuv+oDMBjMyMlsnyj4GsdAtyyq5DhiRwkEIsPrXYQrXvBmOk7JA50npT47yE76SLJPL5mBVwO/udE+NBMihQ8+psROCLMu8UyQcsyy2Tlm2SylyfypPiyTXDfCpeS/Va/HukDPPrcF7W3shpl2IvGB2zXjTi4pz4Fhztj3fYDi50UjYEQ1At6hpo20+FLoVAJVWnnHla3yKeeZvu+i1pCJEjTWEVqK7tm7m4MBbipMujF62VYJ0ocmSbXB4mzlfOotCawAolmhOvY7LW0ZtlZDgJeTs71wxIz0KSVVYDTYMTAOh+F/W4mt1e05MlA7rYi3me3+WdPSi+xQOaVw62IL27fbOTI8HVUbFJjGoDzBHZOpZA+K4cIzfjzV9EZO60h9VWpb3DdvxemgCui+1plsiz07CyqZL7+OaemObNbgO3JlG/gQ7JgmQJWLm3HXQJtPhCgnZgX81aPNmWGedmLe1lEbuWkK4zr33uMu4C0f1VJERhAezh4bcAFg+mW53Vf58Eh4oQfRHTyr5HlAs4fOoX1J6vVuYMIrJyexd9IeEY2IpgxHEfo8ltpMtkgSjMUm8bS/iFjCPBNpgkuGTgHrIhqjeKrSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(64756008)(83380400001)(478600001)(66446008)(55016002)(66946007)(91956017)(38100700001)(76116006)(66476007)(66556008)(54906003)(8936002)(110136005)(52536014)(2906002)(316002)(6506007)(4326008)(9686003)(7696005)(186003)(71200400001)(53546011)(86362001)(5660300002)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RqKaSo09uQ1BeXS/0UZrPb31z79dNmNB5+kOA6hDlAdIg4QhPF4yqJXlEUnv?=
 =?us-ascii?Q?anqCLOIu3+dQIXePJXPEL9OKu/9OuV40frVnGM9OZ4pEOjidBSmM2mVpQqpD?=
 =?us-ascii?Q?NddH7e4/YhGtH97weRo9cWpivMhPEyFbytqhtiFd8fBmGkOb5/sO5scZBQTl?=
 =?us-ascii?Q?CF6KVuPeyTV2b7ODe8T04D/SdbFbiqO2mTlXIY+nl/E8fxZq/duHAjt7t413?=
 =?us-ascii?Q?/A1yKhYJoy12PJ3YSHxvSIxZ731na2azsn9RrmrdAKuvnHlLpL7GNi7Dt4Dw?=
 =?us-ascii?Q?PaHxrff9jChIGkrfcRCdMQ7ddGRKNyWuMUgBUEH7rHEyaF7USuo2bZw45E++?=
 =?us-ascii?Q?EOq8hRM6UhrKRg2hw0CaYERPu8xX9hfhwPkuI+hl8kxMjIvZf5aP3G+fjo6n?=
 =?us-ascii?Q?SExtJ4TO92/ZAfONYnYJW+O6C535tjcXgF2lVwq7P5HZ0AMtZCdBeWcpnAqE?=
 =?us-ascii?Q?Q4UgVg1oTUlJXUBsXmIgiiTY2SJNn/YmFc12R3xpCRtUmO5TUebb/f/9pcp4?=
 =?us-ascii?Q?GteSv5IjJuOWzC1qvfEAyoqyDCg4xWPR6g3QodBqIqEunso03iuJy564RauN?=
 =?us-ascii?Q?qB0L7szUVSZDiPDOraK+X6ZCVvTcOgEzlivC0fwkttDW+Uupz6Awmk2s1Oos?=
 =?us-ascii?Q?sE2KeHMyJc3BiqFsED20shp0JrzowJMFHtc/EmOHcWEqUKrA7wqdD9kXsvaG?=
 =?us-ascii?Q?W2V5vrjBKmnvz+zSGPEGhFIPd37yN9FYTmro8gu1rtn12/7GMxG5QFBkwGUy?=
 =?us-ascii?Q?FOmp4BxQFmZgzZDGXLEWphXtGAh4aQzrWud8MQRdjVdlsvhidMfrddqxbtUt?=
 =?us-ascii?Q?kuiDjKWczHYNoBoUC/HkPMQhMeA7FenDCaNSZ//+9QAPaV3sbB/qlSfnDN8a?=
 =?us-ascii?Q?iT/wTiDtLU4qEuQ/gpNXzqbBdlEWX4sH0Damn82nnWgQGtS7hiY700jOMz9/?=
 =?us-ascii?Q?dE9iaQtG8jO7RlFF1u2iPsZObqrjFePAI2iYEpEWN230lt+3ApCMwP4qx+5p?=
 =?us-ascii?Q?J3CLN+6+WikWvdDH/liBJFjGkMKmeHnNhW2Rid8sFhFEHVNJzWqZ32VIgs32?=
 =?us-ascii?Q?6eO4BYuzmfjX0WIxPaKpbj3f6eBNefA/Lg09sbodkqAoOsvgl+50BcgPFlvc?=
 =?us-ascii?Q?KtH8kQIRm5Nd81TztDGux+bxa1101w9bExu3YoQxYJzRor0LEjHyPgi3TxA1?=
 =?us-ascii?Q?ZH3b0l6n8qzzYun/xdor0+GOOHG9TqiHSd2cNcTYE+v/5dWfX0zNEEvJ1/9z?=
 =?us-ascii?Q?ltaDY4biN0+095Vw0n6+yGkJ10OvpIF96NEjgXMHDW6U7Ovs9MidKYRxrYoD?=
 =?us-ascii?Q?ZnDyt8Tp4vjexv9IeopWowJPpbaV9nL/EobiU6FZA+qnMIaaJoRAdGFI2lxk?=
 =?us-ascii?Q?P6H3LuwgFtdQL7wGM/TlhZrhxwOY/w2e1xEkp4bAMwa/6fzrAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94602e88-ce7e-4162-0693-08d8efd6778a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 21:39:27.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsgQdMCC/aZ540MYFvoxjyq9QY2OGY60xC6DN248PJ6zS2aEDzSOCxIBJ+6aGFHw32bHxA16m+yLYn/RVd0yiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5089
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/25 20:25, Johannes Thumshirn wrote:=0A=
> Non-partitionable devices, like zoned block devices, aren't showing up in=
 in=0A=
> /proc/partitions and therefore we cannot relay on it to get a device's=0A=
=0A=
s/relay/rely=0A=
=0A=
Same in the patch title.=0A=
=0A=
> size.=0A=
> =0A=
> Use sysfs' size attribute to get the block device size.=0A=
> =0A=
> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  common/rc | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/common/rc b/common/rc=0A=
> index 1c814b9aabf1..c99fff824087 100644=0A=
> --- a/common/rc=0A=
> +++ b/common/rc=0A=
> @@ -3778,7 +3778,7 @@ _get_available_space()=0A=
>  # return device size in kb=0A=
>  _get_device_size()=0A=
>  {=0A=
> -	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'=0A=
> +	echo $(($(cat /sys/block/`_short_dev $1`/size) >> 1))=0A=
=0A=
This will not work if the device is a partition, no ? Why not simply use=0A=
"blockdev --getsz" ? That will work in all cases: zoned or not, partition a=
nd=0A=
whole drive.=0A=
=0A=
>  }=0A=
>  =0A=
>  # Make sure we actually have dmesg checking set up.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
