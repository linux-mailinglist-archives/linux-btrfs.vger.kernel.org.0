Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915258206C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiG0GuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiG0Gtr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 02:49:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E4419BB
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658904431; x=1690440431;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GqU7NVM3dVnfmBLReufK57afpVcnJXBM0AOKt+CuRb9lxnYbHmaRlFbh
   rBelk4Xz4n4pt2yjpaXbxNwClAdSA+YL3WkVB9ynm/Mna2B/Vwf+9DWQe
   eVhyPb2c6hJoG0UsDU2lkvVgd+4KybB+zr1AW5rgqc5uO3VPq+flE8Zvd
   37/iMJJuCGg75N/Qz982i/Of6QJCe8xWR7v+66D+E7SLMK1Wo05Vc90IV
   XBpB3UAoZU6OipoWNutylujkIWs4gKPdULtVOxUGPfCEOEnH8c94DHEbS
   uFmIzEOdjtZ3xGqGS+c0PTbKOQD45fTkSDxdstdhp66yFFxfmgClN7lSl
   g==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="319098902"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 14:47:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdhnHfFi/k2NIBw/+atCRFFXtRRVx/xyFldhm8xHTX4XnzMIUItzfhixblYu0I+ZxJgy+KEzt1X4CCCwTeCfI7ydJIZEzwpitmpTy3Njkq7JYMA9Ng3hEHzvbGibtyondu9khp9UxnTbVebVJmLondlZ2Vu33pITfBLjDsRZPbNKhhRhhFZk7msWYyUpmVrezSDZbyZK8asaTw7WvlLyc+xvgW0A/Rn1PxZSC02fFjYQ1FeVQGZ8nwC5yblDwBjIbVJR2fRhen4PYZ3YIPn7dKT5Tl4PvJ2zYCG3caiCqtimDXaHLyq/+epMdGj9PalbLaQbZ5Z5tAn9+CtX8yVXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=d2hs9xbCY4F3+stT4EJ1iV5p14+OItLM0YGVO5DvChs+wSCuMT+csAIbSSBTpGbFU/8gx4AnQTzkcycP/FLFloV6/Ff82JCPZy66Ff6uKAttwGQYmRDpJgCiW+XrvQfrKgYS4hd5jr+8LqTGYEfFl7A75F/Y9/nY6ixowGn5FmmJW1bBFk2ppK3PbyGqhNXIvczVn3ZRa1CKzGOc51cN7xYXoSO+LIUfHkAOmMenRjmvSoz6H87BjX3i7xHkMkDUbyXIoKm45ZY6sjOtzmSKzFUwiXaZfMzVoq/zNUx/nD/kOYSZXyzu4ommb19DncxDZ3/oo1dEl+IkNTDcNzLd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A5zn5WAea22omfWkj7MrXA2rlZEM8mk5DE7uVLEJNBZZX9i87pxea+8bx/ZwLcpZnkL8VZweyigP22Na9ari7vfm5Zisa7+hotGKWW5b17O1Mk5GvKU25KzNBFmhUwWNLXiv+Ighp6dK9AfSwvv2IpfBLnfLQ73eTdryeRsIAsU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB5009.namprd04.prod.outlook.com (2603:10b6:208:56::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Wed, 27 Jul
 2022 06:47:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 06:47:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] btrfs: move lockdep class helpers to locking.*
Thread-Topic: [PATCH 1/2] btrfs: move lockdep class helpers to locking.*
Thread-Index: AQHYoS3GPdx7zgQOmkKGM4d4c66qJg==
Date:   Wed, 27 Jul 2022 06:47:09 +0000
Message-ID: <PH0PR04MB7416B1F192861C6ECC57F6639B979@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1658866962.git.josef@toxicpanda.com>
 <832bf851dbe55b076bb29e8bab499b999b9c2b0b.1658866962.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8dfe598-b73b-4c38-fd26-08da6f9bd3d4
x-ms-traffictypediagnostic: BL0PR04MB5009:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cTkYwDnpVpGif0ibBIc5Smq+NZNJa4lzt7oeoJ7hMdv0ls2LOPofbOdV8ejGDZMhhwm1PFNtuzA0bVY/VUPItzzfj8l8Y0nwzzKLjD/UQzk3HKzs11gbVNYjcyu+hjbB8bmb+XTY/Luo6gMPM48vVTfD5BfkBMqDLcUrCdTrK5/KVMkM6+fi+jqXBiuX8EnYd7TnFdKyz1IGjeJZqSN2pDbsRzaL8ztMrb91VNxHf3hPy2bUT/F/qRu+tK35QkkYKTarucYZd5JTkZAZkrFrQ7nTrRhYdkQa4J5a9BJnlNkzPmyM0/slfFmkjomY+n48NBVOHzdui1eL+TLY0hvrp4rnS3sPOtSZm0kxOf+sHGBSZOiuqrxO/JHcCPytG3iDwEcsKAGkl38RTEUe1IY1H+eClf9SgZpiIiFd9kKcpRJfGwJhx2/Fxpwk0cdpCOHtp3uH39Z7U22lTn2ltj3yw2rITHvZ5fl5TziCHCtlKADZjJtsApCpkX60ly7fYGuCw8XMy9DxPSvoCDFaUOrg/fYjFLzCZ8DTfnG+YiMcA938cr7aBxa0NNtljhXgRUllMMUXbuGIFXBCc/klJQ0oI7xaeom9ON5dzH0iZjcPdciYgLvysPrDFPa8TymQ4pyzyt80GUO/lJlOSwq4B0AlvH0v7fBt03ZtJSMH7ZVHn3/fAjLSw90EYc4IFaUFAdTc5UfD6q9HBCkAgWz+1HAxbRHLpwaTiZ6b36Bn2i1YUukQIIO2XnFrksIy1YLSyYdwWYGpwKd1vOyHwKOPtWkl18ju5NFA8mQrFZLEU+OsiZKdYkt982dbCbzxkgMEXaAo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(71200400001)(8936002)(478600001)(52536014)(9686003)(5660300002)(7696005)(6506007)(558084003)(4270600006)(55016003)(33656002)(64756008)(19618925003)(186003)(76116006)(316002)(91956017)(82960400001)(86362001)(122000001)(66476007)(38100700002)(110136005)(2906002)(38070700005)(66946007)(66556008)(8676002)(41300700001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/4uXpBYYr/ZwJoYgy3/iI3CNqySU3fyFezw+cDrLJY3iBBfJPWH3hK9ZZ9R/?=
 =?us-ascii?Q?W4L7tL2lErxe6Wz3iPdoe/rG5hC/HA2JSsWYPJVFK9+ICZP23011LSzdjjg3?=
 =?us-ascii?Q?wi4DZrodRVr/lTFxgR52smOmCILAg16+z2NOlcrRL5oy2t77QdAxoMQzC8gx?=
 =?us-ascii?Q?1K1RqP0v5PNd+2cK4SPa3141HbBOwz6oMEgdUvEn93EaOasQ5wG5ugoftr0p?=
 =?us-ascii?Q?hqfgWA23cLuu44rBaVTNLeXHN9I5n2elxJd9yq7cCETDO3sSc5b0NQfJVuxM?=
 =?us-ascii?Q?nbw4QZd7/QholvMKOKzV5FoqdEfAZfmAy2i8B76X3mTxca6G5szgG0Bx8et0?=
 =?us-ascii?Q?ajPDw+6FFUu4yezN0ZJOfrUHXzvKdOux7UbZl6JnzUR5wBO5QKsloapnrp+q?=
 =?us-ascii?Q?VdOTLe2QCcd2Yv+jkI6yNIhet6c8Nq4FUc5+vdPKraImlvomfXXX8wGZDcbC?=
 =?us-ascii?Q?Wqkxlf1tIiQLQXsnZVau8VaXLxYqsV7zL/gvARasIG+elxk2OL2keCNODNLL?=
 =?us-ascii?Q?X7q2rOlo2FLMw1hhGzbD7MtOKt5lbOwRIY97aq/sCSGrRSlaRQ0dQanvlG1o?=
 =?us-ascii?Q?t2cgnOVPzSIA4pxS9W5xcjpj+woAWL+g+jxghg/Vws8PZwBHRxeZPA8aXCKa?=
 =?us-ascii?Q?uV++BJw/srSgugZIbFafX9bnuocnSZo0TS1DAO8hv5+8yqKw8ap1Je2Uq4mE?=
 =?us-ascii?Q?xOr4DnfYb5RfAMkcKnYkK/RRpOmMiKfKG5JnP0oGLMjmJX3KCyPuMMRKUYwP?=
 =?us-ascii?Q?WVxp3nODAnO5ctnYxq8pR5E4OyrRhSTFtMXwtv12hRLu8Q+FI4u0FB6pTmP2?=
 =?us-ascii?Q?ezrxuYZNLkMy9KAyDxw15nlouduKfWbZ3QgmH4QOGiY1C9rpKAm6ApoVuNlX?=
 =?us-ascii?Q?ZP+RDcEZt/bHx6Hwm2h4WzbkgkNuwdl42OFrBoz3ywSjalY+hCHmvNlx1q8y?=
 =?us-ascii?Q?DDpaxEr1de9rLCyqnm8soHlKIRjm/Pqgz2cU9yfnesLcnPoilhH1cEnCGKqO?=
 =?us-ascii?Q?uARhF0pfyhD6xt8tpokWkKmLV6/Ocjk4XuNMiyUE3C0tZdNu64FMgK/zvigm?=
 =?us-ascii?Q?FjD10F8GKefzqJgSOD1C6cl6rXwV/FFGgba4apd2+rmI72DipTrK6ZbuFvIM?=
 =?us-ascii?Q?fI39LjSEhOc6vVfqIEavkFtq5a5LM364PGf/mO+uW4jdGW1kO9HDOPckuYfs?=
 =?us-ascii?Q?64nwd1b46Pw67b+O0AfsxeOdz59dAn5KfzknsPpM17lyGMLRcRcwY31FBe4G?=
 =?us-ascii?Q?s421RRQf9O9IDFk5GpfkThjBamKuIM22jlZxIlbqmsA2qcyPIlvh0l6mhszg?=
 =?us-ascii?Q?pxuV5+5JZ4ZENlcXWStr5j+24h3v/7vvvU/TEzqAuB9Q9P0YOof6fKwnnl0H?=
 =?us-ascii?Q?UbBIMZE6hoP1R7c1VOmAmchxlB5GI2Uw1xGVhB3rNeRCKghcPvw4BUP6nTgg?=
 =?us-ascii?Q?bgRVQcCKGJyUKh0jISRfnGwsXmJ8YROIHWisibYr0TXWunia2ZRDV/3Pffp8?=
 =?us-ascii?Q?ZpuUpC1IwLEdBiE+2qB1Nk0LFn+VT/ZhdlQ9bgG6AwLjX4H2a//AgcWVt3r0?=
 =?us-ascii?Q?0dE2KjeKFHZIY6dToDY3dA/x0mgxj8/xNR81HBVm4bXmss+duyHHXezlb2zA?=
 =?us-ascii?Q?vE42Ub8LI4gSav124WQqU8rjKngGbm6ebrb0BPwtgjTiZBsCoOOQV3zdAAKW?=
 =?us-ascii?Q?kEiYFR5UHl0cxfIjSzvr1gMD6ic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dfe598-b73b-4c38-fd26-08da6f9bd3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 06:47:09.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znIhDBkWj+981aZEL9G2VlkK+LsFdiOTFHeIMvG+Gw0gkldFDO5iauxQ16legEmpIE+A53qpKYcauFE3IRcKbKBW0SfpouthFZhVM1B4Uec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5009
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
