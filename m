Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADF6071E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJUIRv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJUIRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:17:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998671A4033
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666340269; x=1697876269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2AayGmTwgforuq/IA29AAcmnYgQBxiexn41kDpCMioI=;
  b=MFB+5jXkzcYc41qE4pjC4trXfmPIxRRdo+vq5FaDySMFjcT+mDdNPc58
   Mxv//H2dc99VVsVViOR7A3p1e20WCoKHRTxBvQcDbPc9zhg5Bvs7hhDPw
   55JTORc1G1eOGFvq7L8T+VsC3NUnzl8xMLZ3DrdoMwIeaQLIkBMDQ89ox
   cjhhTcVlRM9OgOi5KT5+zajgEsLNtxXbJ1ZnsGySRR0Wcz5B/l7596HOA
   PQgF5JSuxeywMiYgw8Cw4NfICbsJOCvzX74fP6QLIGULBofunWSuRu6Qa
   tUs+2anWfSajZKI36TC34pDAmxeawJLYo8pUM60KdMNJCJy8x+YqXt/os
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="212729526"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:17:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFFCWN/frgDvy7HVZnxA/oTPRhxz0CLqvE/x2X/qIcvXGzfOwbF5yCd7Yt3YC/z0w4KPjVE9iquZ7wUX7L9E3k/UfOPOfsvySz4BJHB+cFrdTI6fEArR3K1tdQqIEEUlkdJEqLQybZgH1TlptWaG4IctWInvtAmto5l+74uwxDu7dV7p5a3/mMTK3WLJYE/SdksnyjHOFYIUe2lsvoGIpWuX+61p2+DvxjwdopbENn5cJR8+LoWjN2JraK6cOQk24oX75DmAnKzuvOM/sze4nk9v4eJLF5aMfXmWbE0KVaUBVfhwsFco5zBD78r4n+3YOHoLVUC0CI5rtx5Q73eZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AayGmTwgforuq/IA29AAcmnYgQBxiexn41kDpCMioI=;
 b=MEryWPAEdnPYsF0OYzjaxJC1nv5Tx8tZoZ60GEfHN/GBZIS+udePKeTLmwBKfl8w+YA/bT/FK+1FXzHNM+XRBiWZps5K0uO9NQTvm7HrGDBedAnvT7pHKp47wRnDBf7EcAaG3+OWQLTLO5o//BHFOvBrPqCUjIjNjDqDkh/q5qeT9fReFmQ/8G0EFGJ6u7adpK2Ln3VFJ0/KAi5bUDTrlQZHAGo5avyFoALKeyrUW2Wr1gsmTtTl0CaTST4Kzd70OXNyCJ3Dfw5sbJjXSbDF4oRBlWKJY9S1sycDTsNa7uDG2KKOrWHpwvkSK4gxe0VaNJfvKco3onpl/Q3fADWyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AayGmTwgforuq/IA29AAcmnYgQBxiexn41kDpCMioI=;
 b=FpuseSt2KGFGvOfhWcu+cAlm9PFhuxqgzKXLFhs7ZZntPwlJm8lXldOIn2Ki1ah78iaZ+oZtoheamuMvQl802k6xqLBBjGeYI+Qi4znBLkQRn6gH86BV14Wavuqthou6AtdDvti4ohcdPTS4hAgUsaeohl0L0RfmKWF8tgz/RNo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6270.namprd04.prod.outlook.com (2603:10b6:208:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 08:17:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:17:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC v3 10/11] btrfs: check for leaks of ordered stripes on
 umount
Thread-Topic: [RFC v3 10/11] btrfs: check for leaks of ordered stripes on
 umount
Thread-Index: AQHY4h9j3s776gFp3E+xkGV1NcI+/64Xb42AgAEXZAA=
Date:   Fri, 21 Oct 2022 08:17:45 +0000
Message-ID: <db6f07c8-c5d0-b99b-e9e7-20f2228676fe@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <c939c2fdd361800a4361707bf9d5cc68e30e7907.1666007330.git.johannes.thumshirn@wdc.com>
 <Y1FrSaKIMNI3bWDm@localhost.localdomain>
In-Reply-To: <Y1FrSaKIMNI3bWDm@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6270:EE_
x-ms-office365-filtering-correlation-id: 2d0dcb20-7273-4bfc-deb2-08dab33cbba2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qFNvGKZwhdtn7wrkXpUcbkvBgtKiSqaCn0MKdp70GS3Cnow7PgB+BU+MxMjihRNfBQ4AYlzdUh3OYGibW0LxXr2K3bYAoLUfl6NBLN5uWSyUHlJBi0g2a5GBZSEbOBSpsb4inJi6iw9QNjVFEgF/o26soDAidBFbnOswj3y9rriA1/Dz/Derv+5Y2EdysGHnLSGXYxL27j8RrBQQrzRYu+YLxrrzY8WJzOOrPu+I3SBsA0bg24VaTwkqDn5KNI5QO7vuD+BwjC4PlzK8oN3wpjVUjKgR+n/nhJStTSaH0lZL6fIaeNuetsqBrzzQnW6Q/63hIkZtrnK/0BRLxSsb81m4YSSYoS0UNcZlyoOsvHFKuyjBrGIPsSmDwzxuT5dgySPA28/PNZzFhWTYnS7yecdpeaBajTi6mkHrY6zEGUv0sswwJcmRw18Uk43bYd95TIJjZYB4Env3f8ojs5QznLOQIxlBOTsSMfq7ERNG5etPaBqE/89fH/M0XS7aZ2c8vRaXz8p4H8x7IfG/B5CnBGq7judwr9wICZRP87zWvnJpb3KH88PxDPnYI/gQJKiEgv0VV5XTQimfGX9vwj6H+kuKIvFpw19owkHNVldmAPb1sVGKtP70BtFD6PQrvl5d3bljyb1YSazBNvCaaXjD3j/fG9eRSDabcZDqLeifhPM6oEsIToyBi95Hu8fHO+YfyV8tfUc88WF0PSUf9yMOY1cbKP8GCLX5VUPutW22uaABuoS2ygrjS2JiBXSdRFIWdUxPoguPSLI+3ue2MqjpZod5BmjQIKWny41rQ4MmgQZBayqwbxOilZ4qqqCHMPiLY1i8TWkqUhW/3yY5LDajA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(31686004)(2616005)(76116006)(6916009)(6512007)(6506007)(53546011)(8936002)(66946007)(82960400001)(4326008)(66446008)(64756008)(186003)(91956017)(8676002)(41300700001)(122000001)(2906002)(66556008)(316002)(38070700005)(66476007)(4744005)(38100700002)(5660300002)(83380400001)(71200400001)(478600001)(6486002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWsxRlNoNFhkRlQzT3VRUG1ndE1UV0tlaGVnS2ZyUktYWVgvTC82U0lFc0Rw?=
 =?utf-8?B?OFRrbldRK0c5a01ta25QRTZNVVMrNklxVWlOVENQN1hvRjlJbUtMbS9EVEdD?=
 =?utf-8?B?M3ByZjhwMko2MFdGdFB4RmlqSnlCc0tWSzFYTjdkUXgxY3hoMzk2RVByYVpI?=
 =?utf-8?B?WWdIRWNLWUJpeVJwZEg4OHRXa3dJZkRnZDhDZW9uNllKbUJTNjI1bGJRZjdH?=
 =?utf-8?B?cnMxQmlOcGZEaGltcUxnbGo4TXRmRGRwRENpb05iaUUxMnJ6ZkJCUW1Hc2U1?=
 =?utf-8?B?bklwZkU0dDZDb1lvKy9VLy9pRUpiYzcvNjZ5dGlMWkR1UTZ1Zk5vQVRML1BM?=
 =?utf-8?B?MUhJQWY3SFZsZEVVY3dYd0pqd1RITU02TmRPQmtIZjRoamc4cXFYWFgzRkZm?=
 =?utf-8?B?Qk5MQzVKZGJSYVRpZERhVTBLNzhHR0IxQlBiSHhaNlN4MDNNZTQwMmlobUU1?=
 =?utf-8?B?YTYrdnM5SHlNcHdYYTVjNjhweWwxcUp6cVhkOTN1dm1oVmk3SUF2R2psYkRy?=
 =?utf-8?B?QUdKQThzT3JuMitwNVVERlphR2YyNWdoTHFHaXhqenVEVCtnVml2ZWpxNlg5?=
 =?utf-8?B?Y2dNa0RMWFh4aVpqV1J1OEIxSzVyQlNXK21oTzFXeWd6c2lNb1ArU0lpVG5F?=
 =?utf-8?B?ZVcreWdwUy9ldnlZVStaZXM5UUpIb0JPQTEydjVmYk1XVFE1b3J1VktNUzc3?=
 =?utf-8?B?L2tBL1RMUkRRVFoxMldsL2dwSFBKRHUzWWxQR0ptckJUSkJya2pxakFVeGJp?=
 =?utf-8?B?SGZiNkQ1NWYwcTg5a2E0Z2l2QlpKbmJFUGFGc1FiQTJXRFpSVUUyajJlcVZU?=
 =?utf-8?B?cmxUWVhiMUYranp1b0llWnpCTnBIQ1Jzd3ZDck1tbFBqWVpKdUEzd2ZraGNL?=
 =?utf-8?B?K29pNE9VekhINnNyeHNWZ01WN2ZSNnd1djVwV0ZPQ1RaZUhxaHNYK0xIay9r?=
 =?utf-8?B?SCsrTnlJRVByYkJ4WXRoeFBpenBYVFJNSkFKOU9sb0dydUFuVFFQYXRhM0s0?=
 =?utf-8?B?ZzFCcWJ5UVE0SGxNTW9FUThCaTU5NU16TUx6ZDlrbWxwRCt4dUtyVERHYmlK?=
 =?utf-8?B?UTl5blovN0hBLzlsYjR6MUVLRVBuM0kycEFlWmRWeFptaitxYUNtRFh2U0ZM?=
 =?utf-8?B?THNSNkVUeUlVek5qc3hGRWo0c3M0Y3BvTHJhNnA1V3Roemxqck4rR1BsNDlI?=
 =?utf-8?B?QVhQMk04TGRLc3kreG0zTzY3SnRyVjUvZmttUDdOMXZUc3VqZWFoOGdyOEgw?=
 =?utf-8?B?Y05HeVFSSDN5K3U4T1VOeFptRlB5ck5nQXVNWjBob2VBOENGTVhnT2NVQXZn?=
 =?utf-8?B?NVFaRVd5aXVjNFNvNFprS1V6NnFaMzhmQW5veWNDaE0xZEpNMU9LSXppQnJL?=
 =?utf-8?B?Vi9IMU9Kd05zSTlpUnhGc2I3RnVoZmJidFRkeE40SmZObXFzZi9EcGlESHlW?=
 =?utf-8?B?YzIxRDVHK2ZNZlVwTStFbHdWMGxLbG40cTJWMXpTOEtUc3Q4UkRldk5kL3Jw?=
 =?utf-8?B?NlRNMmdVRFdPZkNtMkZVcVUwMy9xQndVbWVDNTFEelBGT08zSjd2MVBsMUdH?=
 =?utf-8?B?STNiU2FaSVBxQld6UlBxdFN3MlduRUo4bFU0cDRiWDZQTUwyM01qVE9vTTg5?=
 =?utf-8?B?T29xcGhhZU5EUTVSUXZ3YXdqRnNtVEdaRHh6Zkp4M0ozZUsrT0x3MmhVMU1p?=
 =?utf-8?B?M0VKeU1jM2l3RVBFV3BCNHpjWWxEMU9VdklIQXJWVWUyOFJvSlFaRThNZzhE?=
 =?utf-8?B?MWV4eU1qWFBvdDJHd2ppU09rQkFsaHpXL2MxU3N3cWNoNHNHV0lVelVleUVU?=
 =?utf-8?B?WVovWlpFTEFIaFMyR2t6NVVWdEZ2aWp2ak5XMXUreU8ySW5OVCtVWUZqMTlh?=
 =?utf-8?B?c241RzZQaUlGU3RNUG5wVHIrbUpaK0pzNytaREtlWXludXVRMEoxRWxRalhK?=
 =?utf-8?B?R1o5UWRiMmhDbVNncWUxeWdHYlRqS1h4cktqRjVhL2NqaDA4RCtYU2pOaXk5?=
 =?utf-8?B?UE5Qak9tUVhLUmtZNUFSSXpnOU9KUnEyM3AyT3ZhZ29wZXcxb3FqTk80Y2x2?=
 =?utf-8?B?ODllNG16SWFrSDk4aEIvYVdpNGlDSkVXM0JjQUJaNjAzN0RwQ3JzblRySTVt?=
 =?utf-8?B?QnJqUHdqSnZOVHhGWlh2N1NuMTB1dnJtWEthWlhpSjJJM2J1aVJ3aHZDeE1Y?=
 =?utf-8?B?bEZvYlM5VFdkUDVtVFhwSFFLdWpMNFh5ZE9Ub3dQWjJXRHVobUJZdG0rUGg5?=
 =?utf-8?Q?G1r2+w6gi8n0Iyn0FLkADCFnlO9R35UEHkJGPXW7Mw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B67DA2699DB64A9935671CBD1EA4FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0dcb20-7273-4bfc-deb2-08dab33cbba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:17:45.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mXMI5ySEw+zIXVY6Z2FXhRDQnqETyVEipu2TM+I8FRmOPewvQB4ryzV5u9DCKg69NLfRvdhC/WTgddCUX9d4hIihOJIvn/xuvsenMUzxLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6270
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTAuMjIgMTc6MzcsIEpvc2VmIEJhY2lrIHdyb3RlOg0KK3ZvaWQgYnRyZnNfY2hlY2tf
b3JkZXJlZF9zdHJpcGVfbGVhayhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4+ICt7
DQo+PiArI2lmZGVmIENPTkZJR19CVFJGU19ERUJVRw0KPj4gKwlzdHJ1Y3QgcmJfbm9kZSAqbm9k
ZTsNCj4+ICsNCj4+ICsJaWYgKCFmc19pbmZvLT5zdHJpcGVfcm9vdCB8fA0KPj4gKwkgICAgUkJf
RU1QVFlfUk9PVCgmZnNfaW5mby0+c3RyaXBlX3VwZGF0ZV90cmVlKSkNCj4+ICsJCXJldHVybjsN
Cj4+ICsNCj4+ICsJbXV0ZXhfbG9jaygmZnNfaW5mby0+c3RyaXBlX3VwZGF0ZV9sb2NrKTsNCj4+
ICsJd2hpbGUgKChub2RlID0gcmJfZmlyc3RfcG9zdG9yZGVyKCZmc19pbmZvLT5zdHJpcGVfdXBk
YXRlX3RyZWUpKQ0KPj4gKwkgICAgICAgIT0gTlVMTCkgew0KPj4gKwkJc3RydWN0IGJ0cmZzX29y
ZGVyZWRfc3RyaXBlICpzdHJpcGUgPQ0KPj4gKwkJCXJiX2VudHJ5KG5vZGUsIHN0cnVjdCBidHJm
c19vcmRlcmVkX3N0cmlwZSwgcmJfbm9kZSk7DQo+PiArDQo+IA0KPiBDYW4gd2UgZ2V0IGEgV0FS
Tl9PTl9PTkNFKCkgaW4gaGVyZT8gIFRoYXQgd2F5IHhmc3Rlc3RzIGZhaWx1cmVzIHdpbGwgZ2V0
DQo+IG5vdGljZWQgYXMgd2UnbGwgZ2V0IHRoZSBkbWVzZyBmYWlsdXJlcy4gIFRoYW5rcywNCg0K
U3VyZS4NCg0K
