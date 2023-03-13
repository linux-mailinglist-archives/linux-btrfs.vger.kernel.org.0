Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAE6B715A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCMIoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCMIor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 04:44:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757332885D
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678697082; x=1710233082;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=b47j1Mo3K5aE45oo2GuvKdPvfN/E471JwuTB/rLUJ3w=;
  b=WbPm4sMNaZNghJ3gig5ue1MwWseZTy9UsiEU/49yNHFYPuKBXVe8Qwd8
   bZSm1WlEqr6ZRBC5asIbuzJGTCKqLc1l6CuyQyQCEXMGeqlx35XRpD2IT
   hIVmtUC/7CIsVmbmaPKNs2VzaRpSHNeRqkcS443pnncg4Uo2kQjDw0BzO
   Q/EV8QIumOUP6KyqqhGFrCV8c8+gJzB3ZFq2UoguEfgN3imhJZPc5vnJH
   CnHpzGSAyBBhMXQIgVe6b08yiQFVrn+WHZPf9XAXJ1k9PQCXRP9aeN+ZS
   z2h1hhfoWHk54b6Y4xbaelQxO+6wRUf3oN0SndP/LX+V5aqWJZ5zUa6Cn
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="337497772"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 16:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvxP2IjYiWvwFklMfqtGI1F5tpnDq2Gy9CWJepzjhQKpq703U0W+hb0fHheckTVc8g8IV9Eap5PoOkEBlMifDjg451uyHFy55RXZ1NeXg19h54qBlMPUQF+LSUh7mFkn1X8vQw39K+mnX7c/7Eqiq3hXhs+wQEB1Peqgx9+0aH0LC3V+/8sOEjqTxeLvKqbyMMkFN3jgn1eI+ceIQeRuSYh0dD3PlUgCBbHKxtdPXd8bs9LO63r3jP3wlF3WQFsbzxa+1jqGTnHem/LzhdETdAabgE7tiKtO4OQrAjF03wM8HrxQMlhR+n/gXkrB/G4m5jtmDk2I0jWPHfKji9mOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b47j1Mo3K5aE45oo2GuvKdPvfN/E471JwuTB/rLUJ3w=;
 b=Fd7PSe2OxPT5vJzutkNDbWXDYAaDRCJEk7zBaCHr88vm/3459K2epLa1r0g8l9PDlEsvTyu+eV/c3L87NZULQxPUBgveOJpMpmMhdqqYfQ0KS03/v2s62saj3yXUOygwtqsKTF4z5k7Ih7G6j8QDAqI0SZLSxanTdji3QeVSUidsAdJKvXelVGUTyjHUA0UYUSSs1cE24DKwf+Q9lpU8TblqLost2G/3WSie9GdnkK48htbPM/edn4JuJ1rBmwf3nVg71fpdHy7R9bmRbQdzuStFdYvsCMHljzdL+PPO8yDAHz+cW5vFiv1WDIqUGPUSF9Uent6GVNJAvwYhs+UeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b47j1Mo3K5aE45oo2GuvKdPvfN/E471JwuTB/rLUJ3w=;
 b=ZYTuR5h/Luz2pMsPZW5rklQWMK6vY5RGubF/z6moGN5n5HRiYIXjvuTAHGycHwbXP6Nr69gYDOGf3OwAWRVqp01q7a4CacKprpwk76SDwrlXbKj4jpd7SwjaEpXTiT/eoo2h9QLf5wNB/UfSGgl0vlyKhkvhdR8hQ0Xch1kg/Qs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3521.namprd04.prod.outlook.com (2603:10b6:910:8d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:44:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:44:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: relax bg_reclaim_threshold for debug purpose
Thread-Topic: [PATCH] btrfs: relax bg_reclaim_threshold for debug purpose
Thread-Index: AQHZVYARuLZsFcK3OUCeddUQ2BYf2K74ZRWA
Date:   Mon, 13 Mar 2023 08:44:37 +0000
Message-ID: <8f98cbcc-4b7d-e7a0-7e99-09f9e5a169da@wdc.com>
References: <d04a158f989de1f564cd007f05fd51b6b154c006.1678693572.git.naohiro.aota@wdc.com>
In-Reply-To: <d04a158f989de1f564cd007f05fd51b6b154c006.1678693572.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3521:EE_
x-ms-office365-filtering-correlation-id: a32a0e5b-bfa1-407c-9853-08db239f2d9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ig/4GHJaY7u/CUtJBHieMq/AnC0kF9T1uCXriAOS6QVWhlSN+VQjS1kidw+pWKNxzndeyx/aIlNatHCWPDJJYg+c9D7fP3+1rFoG1lMq+fmDLJDZPA/Daa8q2dJcArta84lM44jUIIloBEL++ugNcWpgcZyM7Gi9qkySPBJwgGTi1BDEx6BMsvVoYSfriTL+BNud7gh/FkbRkGjNPc0gGW471K2WakZ42H3QBitfE74KXz7hbpzIzHDqUSB2P0JYwya9sOyU4UzzmE0fL04MJIQ6XibuoM2qkVig7IPunSTORWjO9Pczy60MC7cOTZdNluADCCBy3boFvtft/ziYKqvcKT1ln0wp09NrjSBjfWIsN3WFMx6g8hnM9NTmeM8IMmAT2nKjzMoSkEclutV3FqbECZB6wHBUKjYxQNFmkGYPQaYNhD/kxQz31etCdhnOriA1ume1m+/FCf4Bvb0l3b1x4aVPA9NBwwTPGGxyxTBksiZ/N66JWgC+pqsC1SqAKOvGiWoHWBKiOlmGVEXoTVb9n4GQCyo6VIQVEVViW7MRPpTnJjofPozSpAWd4Lcgq/2N5ND2JrTbEnkfSOWZ3fjKfdtRn1bMz5LMhkcXnDtneEYt8o9N1mYqaWljWusPpMT6td9WCaWgQcbIyl6u3VCNccxpBK65asyZcGtnDwp6dRQ4IRGXRyTX3iWeAhc7G9mkz02VH2lnIxG7IOgnh0bu79mIOx77IHRNs/vOXooTcOXMDy+QOYc7DsUSSK0vTgx8AWAgKhD0WRzMRSxF5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(2906002)(82960400001)(122000001)(31686004)(83380400001)(5660300002)(36756003)(4744005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(41300700001)(8936002)(38070700005)(91956017)(316002)(38100700002)(86362001)(31696002)(110136005)(478600001)(2616005)(53546011)(186003)(6512007)(6506007)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MktrU2lWbWQxTnoxSlRJYWpIQzdzNzZ6TEgxR1Zya1N2KzM0VlBJTXUvSFYy?=
 =?utf-8?B?blh0bkFQOUpPMU1OQS8xRG5INXBQek1KeXFndEJkTHkxQmxkZlJTcFFhdVBx?=
 =?utf-8?B?dnExOTBMdVZmV096dm1BekUvL0pXV1JlN05Uc0hTV05acXBPVGljTm5CS1Ar?=
 =?utf-8?B?YjZYOUdubC9TN3FLMjJ6cVJRa255dVZmUk5iS2t4SU54ajg5VWtwMFpSSjZ6?=
 =?utf-8?B?K2xLbVBveVJRaSs3MXNTb1BsYmNtc3BWQWNJVnk2b3JkZXlNb0E1NHhqamZ5?=
 =?utf-8?B?dFdjUGw1SXJBOGh6YmhuakdaeTVoZWRTb3duMW05MnlvNGFzdGwyWnZVMTRo?=
 =?utf-8?B?OVVUanBJVkQwUEpwTXN5MkduZE4xTEZrM2Zpci9hZ3NieW56QzRTNGgyUjN4?=
 =?utf-8?B?TjVLTFlnQTlHSEVJc1lkSjJ2T1dMWmZ0N2pPV2V1bVpRY3BSQTVzUXRITFZ3?=
 =?utf-8?B?ZzNZcXVtVldVai85c0RSYTdPUm5wRjNRTDNHNnVwNkNNbm1hdHh4TlN4OXBz?=
 =?utf-8?B?aGNJVlQxVWVYSDN5M0RNdGVsSkJUSUpIWGxLaVN0blJXVDB6dzdKdE9pTlFM?=
 =?utf-8?B?WkYwVE1xcmhzSW9KVXJ5Z0RRa0lpcVd6ZTh6UmtCNFlzRnFHaDdqN0haUDdV?=
 =?utf-8?B?TndFeDFSelV2RzNjYU9ySUNheXIrcTNOazJrUkRnZXcvQ1djaUNFVU84M3B5?=
 =?utf-8?B?ejNQOU15MlBGOXoxV21VK3pHOHV5MnZ2U2ExNi9jWlhTOHZ2dFNZeUlyUVFK?=
 =?utf-8?B?Zk5helRONEdWT2F3Ym1KMm5NaXI2OHJqQ3YyUTF4TmlkWVlPWFlCMjZEemJ5?=
 =?utf-8?B?d0RyajNVR0xkNldDelBHZG83MWRJRDRJc2hkUjc3dElTK1plZXN6QmRKRTFy?=
 =?utf-8?B?NlFwbXpKYXg1QzZhRDkrWVdiQS8yZTg0QWE1Vzc0WWlnbUY1Ty9McXVLNjdQ?=
 =?utf-8?B?Z1FyanZPcnBHTzEzSTg2QlBQTnJKa2hlYmwzM21XbDhpaDVtM05Xdkl2T2VX?=
 =?utf-8?B?RjZnaHByMW1XMDArb0Fyb1NwbWRvNVFyU2dEdHZTSFRQYk1xQW1BKytyR0N0?=
 =?utf-8?B?NHA1YmJGSnU5ZDM1VnV2dWJZUUhWd0U4Mm5URUhJckJoclpGWFl2ci9VNENL?=
 =?utf-8?B?SEVKcGRBWE45UUdJV2FhWUxJN1RFMUFYZ2o1ZWFyUUxhYU1teENGV3Zsa1FN?=
 =?utf-8?B?cWMvc0RkNU1iS0VBM3J3NEx5RU1RN0VBb1EwZnZQUURUbG9MMnp2aWRxS3pG?=
 =?utf-8?B?ZjhydHRIV0EwbFlKSXV5TFMrbUFIb0d2aUhwNVVBSVJ0TlhWZzUvSUxBZzkv?=
 =?utf-8?B?djgyQWdIYU5PN2duYzlIcEgxakoxNStZMTZWQk1YbVVCTENRdGEwQzFiemJa?=
 =?utf-8?B?Qy96VncrdkFPZGhYN2t1Z2sxZkZtWmNMM0hKMzVremo1cWZRNVNraDFja2dM?=
 =?utf-8?B?U3dMVlBDbCtaK1JXRDZiZFlSYVhGdER5OW9kc0RqRi9TdXdGbGczT043NjEr?=
 =?utf-8?B?TUtBNnlMa3ppaEJ5aXpYNmV0eTZvVmx0QmtKR2NnODB6MEhma1JwREdyaXhq?=
 =?utf-8?B?NkQwSk9PNUczUVhkUWxnNUdramRwLytLWU1obTZFd1RpaFZwMEJGbWpqRkZG?=
 =?utf-8?B?UkF0RkRvdW1vWWRDYnBUUXhCYm5KOWI0R1dYVDMvWlBlQ3M1TlIwMTBnMVd2?=
 =?utf-8?B?WFBMTk1nWEtlVUV6d3NvRjJuclF3MzZjbnZ4OXBoR2Zxakx4alN5ditVN05V?=
 =?utf-8?B?RFQzWHR2NGpGbkhOb2VlQ0lDOUtqbHlOSDJseEV6enoreEczT0pMWHh0SmEr?=
 =?utf-8?B?ODl1cTEzVi8xV3ROdXRHZ0ZMdCt5OEZRU2R0emJ4ZVhWTmxIZTZXaEh1VjZl?=
 =?utf-8?B?Q3FDWEtSN01TQkxNN2tYaWc3RXlwbmxPSkpOSXBCNFBMRTlKRFRWOHlYSjV0?=
 =?utf-8?B?b1FtWElRcEtzSFV1bEJMUXdHTWNMb2ExNnY1aitPV09GcnNjbTFhUmVqY0NR?=
 =?utf-8?B?OVVvSmphVTZ5RlRLS2Uxb1FFY3pNNStEMS9SbnpEWkZMUDVWb2J0MXNRWjgv?=
 =?utf-8?B?dVJ3WFl0UGpmdHNTeFdzZUtGMk5PRjZYdkgwTHFtOFFoN3dCbGJKWVdxUmZI?=
 =?utf-8?B?WEhmOUVSSy81SWg5WVNLQ2JNNGxkTkVEUUQ5cDgzaU00RThLQXlWMmlIN1VX?=
 =?utf-8?B?K05kRHFTaHVVY09VNHdFZm82Y01Qa2VnMTFvQ1FaWU1VNjRwZVRxVHQwMXBp?=
 =?utf-8?Q?FLjaqhuB0rxCWAUUdGIkuwN3XpnVswoL9JuHlP532U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDC5A91BD2CAF48B4BCCD689F7B1213@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hJNbjcopY4uDATZKhQbHgbs+8zEAL/qj3OOKzbII7285houQbpK5q7LyqW3lakLUCAvcnxL4k3w2Pf2wKoW4tR9cyvziab+nxA8JD43OwuWcg8Rbya8V+LTZVDGdqvkL5xrqbaSQ6Z3wwW3+j/3aVseJI4CBeXcpNTqRsg/J3fby7RGNo8yRH/5gARYOJTaWA2VPHj++lYm3jZtZ6aMgCp8Jc/b/odqpDrhvXxJlBQ2Smmd8wUy5z1WtSWPZucmjb8+gqkf7bZA8isZKxTAO27a4Y6b2Vyz73ca/RH5XLV+G4k+GD8MHZcrbhCCfLfCh7mjZ7wT7I85UaU1wcAnaCpvcYuDS7CFGHckxyZj/mkSh7byJ2nDKtvQfhkdHxsq8yVZrTXR1fUqxmGusBDHYVOclSsW8oHGL155mFvwdSPr1YuSn63FS7K1NNIf+8/F+xK2Lzf7ZL5aCnUvBJZv1+m7EVO9D8HJmkYmgv7GNvcMqTz7V9b8SYnI41JCQ7Ngi9qVM9CksfxW9DsRG61lV+Iy69Uh7yJznnxa5B0cz8AA8ASbpBl8HWNjJwrFj0JkGzuSbuhYI4k9hSZmHHN8oK+BZgXqe/yCsZeJOtpE+37C4EHVgA18IwXBzh9NMzU1QioRUz5v/erS+PgquU9OepWGY7huGdI3JFZAMGdpUC33AwPZrbybCmeXG43i7z/mpHvHZ0ftY5KN5M7Ng8RqIYbcXG8oSNRNGvCr9xxBlf0DCXII9rR+eyn70d0ChJCaEXzrQY08X4eQAQp2U82sDPg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32a0e5b-bfa1-407c-9853-08db239f2d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 08:44:37.4950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpVIK8VeAve0pSN/u2KKj1BRnzOd0ou/cIHAJ7k+IRQ6raSlcm7SW5MMPXiZJwixpJHqGGqgC8fhO9y4Ii+Bf75nT4grqcy45wB/uAY/RV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3521
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDMuMjMgMDg6NDcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gQ3VycmVudGx5LCAvc3lz
L2ZzL2J0cmZzLzxVVUlEPi9iZ19yZWNsYWltX3RocmVzaG9sZCBpcyBsaW1pdGVkIHRvIDANCj4g
KGRpc2FibGUpIG9yIFs1MCAuLiAxMDBdJSwgc28gd2UgbmVlZCB0byBmaWxsIDUwJSBvZiBhIGRl
dmljZSB0byBzdGFydCB0aGUNCj4gYXV0byByZWNsYWltIHByb2Nlc3MuIEl0IGlzIGN1bWJlcnNv
bWUgdG8gZG8gc28gd2hlbiB3ZSB3YW50IHRvIHNoYWtlIG91dA0KPiBwb3NzaWJsZSByYWNlIGlz
c3VlcyBvZiBub3JtYWwgd3JpdGUgdnMgcmVjbGFpbS4NCj4gDQo+IFJlbGF4IHRoZSB0aHJlc2hv
bGQgY2hlY2sgdW5kZXIgdGhlIEJUUkZTX0RFQlVHIG9wdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQoNCkZpbmUgYnkgbWUsDQpS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNv
bT4NCg0K
