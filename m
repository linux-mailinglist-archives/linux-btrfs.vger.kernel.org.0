Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9885650F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiGDJe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiGDJeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 05:34:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC221153
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656927215; x=1688463215;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rEdnTSe1KRUJStvJw/RYnuVCV+dEPV9EWALOaSOp1JQ=;
  b=qcKyoCF29XquB10/mZaBZ2fBQ2rEeQBcZuTL2N/S8eF0uxU4TEqDrtoV
   k4IDfAJnUzcMF6LuzvqfkI4UvOBSmTJ1pJUPD2S6vZX3Ay6fma3sLLPcv
   NGq1sAHm254Q5IZmwSOqVY5O/bN7Qn2z9UrWM82XHkotog0+kFcS6zLrA
   8XVoOXzHAebGrbAkpAsUiKl0Gi8PzAVDUQXPDmOBpKOO6NCk0HX9GFrvZ
   Qs7iTmf2xSSLfU8StOnU8JRgahMNl1iWILLcnvz/8Khq9nAMXUZETL4a5
   XnvQlXvwbYN5CCaecX2cc17gY4CgE7u3hg5V6lcBU41uzTHPiiaSBY0SG
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="309076211"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 17:33:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG8AXjUHi7gifdO30lWWddyBRv5b9XtvMVAKuABlvmYlwZpc9ILdPdQfORTIr7WJgg4wDJu5n/7DwW9lzFnLn8eFaXzaR5HDrJxBFaU8i0TC6KwMb8UhwwZVHqISr0YLOS7ldeW5FJNQd81wdim7To3GF8sCKvJQoUl+10ShVXxLJS4XEdQl+pODebK/3jzbUY07Pc3yll3syCMP7K/orsqNUEgHmW63YWz9AeItFzlHXRhZqhUzJeolIJQN8N3OYIG2Tqk/7RmNnRwvuF09hE5u5mSANa2EgAqXUu9eES/E4hkBKsUWDDJqGtmXZFNki/ivdfqUUYIJRNLmIKEk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7w/3q92y3EFu9JxWyJG+DSyiFmmQHyl8oaRaK5HuY0=;
 b=l0dEbfVFTaKCmIbclEf7Aqb9hWLbk7H6V63N1UeRQXEs8Gg0nlPUyDSdLskXGm5UjUM/C7Md+dB7/jCrE3dnI3NrP0XBknv72M+b+1sKmJtkHXRmA17hUw3w2WLu5CHPuZzSqfRBD1VkhmDpXIr9tGz5kahh0UG2sJ68FGFgTO7P1YxKKvVlN1NegoCG4V27kujvuJRFgGhBDKQEc0g0T2Zbq8hHa4mrbcoxC9tBLv3VmuuXvSXSCeg0a+y09CAW1AXPNfS/I8BVFNUbSM86DtOWmRFo7O+L5n+cpD19HOhmZG7cJ9ivJUbbVMLQk0VYnXbQgUTkxcOV/E/AtmJEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7w/3q92y3EFu9JxWyJG+DSyiFmmQHyl8oaRaK5HuY0=;
 b=PWfLPMle+0lPNjyTWJLNH3NtB1lmyrQMNZ35brflFULV1uCa/cf26TwU8VphJe0n0yolRX/0J82EETvXX4W0Rc284rnI7kCDWid6jCPrqCx3zsMVdKoVIFYFSaUo0bnb58SJMGxuey5KvUdCuiC5FHn7tq9ESSSc+7fj+xeM4yM=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7168.namprd04.prod.outlook.com (2603:10b6:a03:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 09:33:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 09:33:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Topic: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Index: AQHYj2LHZWVXGfLPhk+1MqfkduoC2Q==
Date:   Mon, 4 Jul 2022 09:33:32 +0000
Message-ID: <SA0PR04MB7418687C061CAD8104CDE8BF9BBE9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d344465-29ce-4adb-02c0-08da5da042d3
x-ms-traffictypediagnostic: SJ0PR04MB7168:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MszsTKPtQPCTZkwBmCfWUkJUHxOFkAMBZdHhype96/jn4baHtoix0GZC+mNfFoE3kHJryHZ3C+2gxoVyVyiAbhdSx9uLU2W2lTOUtg0OWPtxykVgcqzuy88w1C117WMU51VnB8/ZbjOH2C4dTnkRM1leZKIBZB+kxzL1JARCNHJGtNp8PVRT5JilDMsq8me6VKjeorI5tVJ63v1+zYhN5kk6ZVcHpOigc9DJT3Vo0VXRWcm0sHMfa6FIrx426MNVfqMrm3oKrmefnkey+cTBiA+SpUoYgxmv/zY25xtvEJPYXYCTRbl7SF+1UxDALGGk2CsFyA65eWgOoEzGnUi4vq/ZmjDRZ1dtkIanMoJxbqbsCqvqBFzu8v0f5oFQGAAolIs6a4sdcViEdKeZ5dQ5IxqwxN/KbdD7FSzrT4182oXhqCHljLwUdC9d2ye76ePYzjEK8lbfl0BK1Y1IznER/Dd6uaphEKFUhAyll0+DJqNtFWCGS1ds4chvyQTZwp78Gr9YtJhL0W/SiBkzC6i3drDc3WUS+BEyidndTbKWETkh0WZHryVFjWrZ17tlMHh0NE4w8eT6pUGg2kb7NtAizWQbMUqsu357JSGHMvjBS/aDQEUdrbfLXAPK8TQbFcl0ZW0xQFJoYIsIrE7ask+tjwCfcDycpAb5JfJN8QVRwLvIJpUgAiBEE/hT5rYf4+AQUZ2nqxUImvIDAF24E/vcG/5Xcg9vTY2uXr3T/0UGocMxSAsobZR2Ri0sJfrwTGW4IAQVgMniEWF/Ahi+fNkBHx6iUlyMfMasAmeD1wK0sMVn2ngnuACWlRnW5NKuOJH+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(9686003)(186003)(7696005)(55016003)(6506007)(41300700001)(2906002)(38100700002)(8936002)(110136005)(38070700005)(82960400001)(122000001)(478600001)(4744005)(5660300002)(52536014)(91956017)(71200400001)(76116006)(66946007)(64756008)(8676002)(66446008)(66556008)(66476007)(316002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WdN0lkmnOn2c90tpCXA11d9dpE08EgPl8GwE1Fsm5BaIr7+cVEPPBkWePGA?=
 =?us-ascii?Q?tNfBskW5sBZNUCG82ZdYzMbsc/LeU0U1BiNJCd5ZXLwsQXEFfKwrxkWf1ojl?=
 =?us-ascii?Q?6cLXMFEiFWi3LnXilVshsHz9RtKTnFmY8/Lk5gonTiRi07Fkc+qylAGHXH0F?=
 =?us-ascii?Q?hCE2d2Ow3zdqtqDGw3fGyOf7wHkBD7b4z7SMIRHau1xfWk/TRNBybRlKGJxx?=
 =?us-ascii?Q?y/o0K0EUsofyKUcLQq5lmrQa1MeuW5vZKd1n1/CkvGo9jC6uZfVrWc7i+M5y?=
 =?us-ascii?Q?/ZVAgIqM6iDZTYhOYQcR2WCeFYc8wuaVkkDj3tvB6LbEyUfY9S2PPTpg3ASJ?=
 =?us-ascii?Q?mTrtZL7Z6yYguQ07qF2Vlmn2Zk5DdmAD8/EYgwnwd2HJ7Yyml7Tcynh9FlT9?=
 =?us-ascii?Q?XT5BP0YmGtMPuN3ccMtD58dhgEAhXQ7XVsJTLYCmOjNPkdDuUEV0K84Q8ak6?=
 =?us-ascii?Q?xc83/Vwc0ey658ksJrSoU5VGXH3nhdir4Rp3rXBguNzM23IYJV/OuD+3BR9S?=
 =?us-ascii?Q?9Dwz2utwkIwpHaf0hYDzXwNKkdGbZ9spMJB2h5fEJr8eDYNIOWJ4EkC8IfDT?=
 =?us-ascii?Q?sjaDEJlMZ9K2JR1xXPeHtlTPl9tHidftYG30Ly6ddhj++sAAylxbYkLs+yv+?=
 =?us-ascii?Q?uAfQKdsZjHAx5XnAtX3XfP+uaOQfq0dCt3vwHF/wLjPncpTi1ncKdS7+Vkvj?=
 =?us-ascii?Q?ykcUjK9i4Shb1Q7xsOYtGFLfeTH1R4+XXwDRFQEP0jdBZPOaruIlq4dz11pD?=
 =?us-ascii?Q?oSsr/gdt8WbtdrrT+UeFTQQeyvcj2mYhCoNtP5i4B3l8dJS4/YOclzDvT3sy?=
 =?us-ascii?Q?QaklZ7rBUbRoU7rF1fVXx9JnDpwh7P1olZKlMHZM/oIwhlL0mrNXsb+XvHm/?=
 =?us-ascii?Q?SL8mx7HdcfNsrzPHrLSuLZZ7KcxpnRfMTqsRMz3BTTwuC2s2Uocx9Jvj/0mW?=
 =?us-ascii?Q?mZww3LgHeayck+6ZuWq6GnuCkjgStDt3a3usOeAHJzK/+EEsRJ+tZKBRfyjl?=
 =?us-ascii?Q?tb5alZ7+dyfEgTGQQRnIVN52tIfGkzosk5Ulg1ZVcKhOd5yR2lPbAZTm7bCr?=
 =?us-ascii?Q?3c5l1KX3XaZU3XE+EK3FBu14JgpuUgw9AgQkRwI+sMNgnssmXrw9GYqZBfsu?=
 =?us-ascii?Q?vrvdw+K82j+cQ0JMqFeyO41NjLyuPgLNvA898go21FSbvnrwlR3Hqq3N6XpW?=
 =?us-ascii?Q?o8dTyZZL1/bUmeDcxFCLfszYRlKEJb4qUyOzGzN2ZM/TGdtQYpyPWqFYxu48?=
 =?us-ascii?Q?911dAbJ+zay3g0pCVbOTFlBqwJZZg+O0efbjo/jkWPU0vmrQyv/6PoUqvar4?=
 =?us-ascii?Q?sMNfLRHZt3T57sPcuE/65SsztUFuvpFNrfGwhRaATMEHxU6A899Yk7NlvFYi?=
 =?us-ascii?Q?lqVplvMBXMl+LyQjkUaeOeHPCo8HcfSpYdD/Z+JZT/vZwNSEgpVTqtwJ+aeg?=
 =?us-ascii?Q?MJsBVYzHg/xBjhdzfA7v1+7p/OamihC7FDEtddqlYnjHKtg88TGlz/VfUp4A?=
 =?us-ascii?Q?qeA0RubiAnWAR30sqIX6WHVgm0uF4+5Szf/E+vYKSu/uC+jSXdcX44NZ8uZe?=
 =?us-ascii?Q?KVnblBQp8brbOZFws8MxkBENcUOeIphTQjLYjS8ABVXs+f0iNVHS2R7DcIgf?=
 =?us-ascii?Q?HJLZx3ujVSOFAcMqTRMf9gNWFMse/QYkuTeWU48Xr7UeLmcRHIJUAU6uoUhG?=
 =?us-ascii?Q?Y8PzVzx6JKOnHLfhlfyTxLwEWeU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d344465-29ce-4adb-02c0-08da5da042d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 09:33:32.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ws2tF96Nxf7oZZ+DjcYNt9ATCHmaETjpO7PsO6A7PauwxL34uYoOt7wKcdJA3Tu8iEUHD/dwEUy2ruNCPYsjOGY8mbSdQHheFgwaVFVbJRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7168
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> @@ -723,6 +732,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_i=
nfo)=0A=
>  	}=0A=
>  =0A=
>  	fs_info->zone_size =3D zone_size;=0A=
> +	fs_info->max_zone_append_size =3D max_zone_append_size;=0A=
>  	fs_info->fs_devices->chunk_alloc_policy =3D BTRFS_CHUNK_ALLOC_ZONED;=0A=
>  =0A=
>  	/*=0A=
=0A=
Thinking a bit more of this, this need to be the min() of all =0A=
max_zone_append_size values of the underlying devices, because even as of n=
ow=0A=
zoned btrfs supports multiple devices on a single FS.=0A=
=0A=
Sorry for not noticing this earlier.=0A=
