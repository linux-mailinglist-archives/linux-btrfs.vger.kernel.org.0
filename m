Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8226A18A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBXJXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 04:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXJXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 04:23:18 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC225E0C;
        Fri, 24 Feb 2023 01:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677230597; x=1708766597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AmnyvgbNVfWQyiCsqQ6U5Kp8Sbqx1MMqrMY93GvtfBM=;
  b=Kxiz1fdJruXrsxRD96N0MVxj5jufTuskrIZDC23n85VgWHHFIbjDowpM
   9PwxwW0dLfVe3KflkvUiN/3+bzuhpGcGhl4NlpgTub1A/znVY9oopIT/I
   +t5Uy4Bbg9SWKfL3SJ4HXsjj95irybds340rFbVyWCvdeCd5kIXntXlmy
   nufOWk21utQ8jCz3lx1Cus+SYhbEcIdrmcOGMD5Z0X9oFmNfDdmqy+9TY
   bs9A2bjNqON5G8+VmTBgW/kdB4qjvg//TCtb1hO7lDfXSZU6okDLJ3el1
   lbB8hX1L+CBESKcN5ldYgdtmeMqL5r8LISnHjHvKtDQ6cnXORIHpkQcdP
   g==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669046400"; 
   d="scan'208";a="229085343"
Received: from mail-dm3nam02lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2023 17:23:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP3jfndz4XWmicgYTTo9hhtoCpjl3I9EsG8pHsZ0VANnBRMjCbQGr57Fj4WDrP/FAR2ftmmHK7V8v83nULtyhqXUSlsgq/pfUvMOp/Bd/e04ww1pMikM5KRVju3470fZpTbPY3Ae+8iJfQPxZk7966nFNKMk+0vxHH7vy0h9KX12YPZzeWFRZ4tsrQA2Z1EtNAl1GLTI4V4mL/xuk37c2yGwBtQSoK4MCfMHH71xtrb4hvEd30dm6fSfRGOSFYWr3ksRmyqzCsLM9tn00EN0HwEZqUf4b0ujabq1trq91MraAFFvXD++AhHmag01/Z3w49mna8gjraCWHymBwEb4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmnyvgbNVfWQyiCsqQ6U5Kp8Sbqx1MMqrMY93GvtfBM=;
 b=aAbzRW5oosly6/uWv2RDeG7KLw3KIoGn5ygGQ/XVPnJVqlQPMeYLNyxnXIh4GBLQcN4dZVqlPxfZhfbrMP268KBVYgsICky5g51Rb9tkFP/nEq8wQNEwUjgLoy8QGcePE2X9okq4AZFhh5B/3bI3Qsq2UZqiUZqBDGWvKix9thvpz6uo6y1ugRVChu2qJd5VsBv3rb0X6NQB1PX49lFqoplsYsb+Dh4S0YJbsiHyDM0hkQBtzUecNkgyRqrcnfZQ0OC6QLVBtTk0/wf6j+/zDBwccOjvWKggOtLMGB8YXgq6VcOD+I1lLnci9rfjX0F3nrLGyiKNPLt3qeEhO2CPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmnyvgbNVfWQyiCsqQ6U5Kp8Sbqx1MMqrMY93GvtfBM=;
 b=aW+yVFrMH5h44e1ZWJyuxRYFYoeWNugXKHHMWjGj7z4vg1n+j2jU2HHhvH4eC8Vql/ug+nOt0cJJrZzAZ/BYXD/ZMHyn+CBj1AfFmkxvD1CY9FDYJJzO9Dj44M71InTEHWX8SDeRzYfhYB7Ky9r2BsX7wpcps2CEehpJwdbjo24=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8197.namprd04.prod.outlook.com (2603:10b6:8:c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Fri, 24 Feb 2023 09:23:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Fri, 24 Feb 2023
 09:23:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Thread-Topic: [PATCH] common/rc: don't clear superblock for zoned scratch
 pools
Thread-Index: AQHZR50zoLOS8b1oxk+LyVydkDFMUa7ds4aAgAAgeAA=
Date:   Fri, 24 Feb 2023 09:23:14 +0000
Message-ID: <075e4040-b1d8-4b76-b9a4-b08cc72f8156@wdc.com>
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
 <20230224072344.go5zzsrex23f4xt6@naota-xeon>
In-Reply-To: <20230224072344.go5zzsrex23f4xt6@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8197:EE_
x-ms-office365-filtering-correlation-id: 00f4573b-f02c-4a28-c2f9-08db1648c166
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2TbMG55xSPQSw2dw5DcRwzNZGc2YlZ/IbPLx1/7AW45WQ9zSr8QCLkEthJbLsxZ2mAyw+iWFHoMJqI2pYaNobsmZYq5eayD8nY3BZJEbU2ONOB5lFWzmg/WC2zV5qbqDyT+skW4yLF9MS50vtt8Duxq88j5Ab0Ts7Q6V5/aftb+qVIL3LM3PVwA3mdi/xO179YU9nFHA3GmtSE+QpxJj4atC74+sIiAsYaWhoBDlaZszhpTov/R/Hvstu0N5ZoYybGzHCSIxyt/xd1658M2dtm/vmruWYqqcQUw1ZN71QYsyL4HYB+8shJ1CjPWHfuw/g2DelDUTPKsRoT2iII9/zNEpRi8hF5NkK1b1FqoAX5vNTw60RFRSJgV73M/IGUaC4whDAV90NRWfuR8x0Vss4TZ5W3X11rFrGGJHmQ2ZDbBnoYRPeIw40OhNv3atzYQmH7+7AUAqfGEtINQUS1KpQt9e9nyjlbx4NRDdDPkSSOj/GFew9rbZaxbKOypnw0fhQtrrRxO9tIZ4TJ4/zgkj7qiWqRuRVj3OHad62+PSVtMHeCe5qVhSs+c0JmraeX/7QO91D/fmtQghxwkwMOfVOI/UQ+LmUkbYIQhdQODdDpfl1mdAXJ99JmQCzp+mfvh9G/3ezw9X7DCYXSP806NSgJ77VuVZHUNHXi3ES1izTOQMRcQ0qJm2BbWW4l2dfYTE7BvEVdMvm+8BjPs3w2CVfAxCUiyYi3He8AmrhQuc5ckiYTYO0ZHhrQSHOe4kCeVsCjsPVwFFqJscrFh4Fbg2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(478600001)(71200400001)(38070700005)(82960400001)(122000001)(38100700002)(86362001)(31696002)(2906002)(37006003)(316002)(54906003)(41300700001)(6636002)(36756003)(5660300002)(4326008)(66476007)(64756008)(8936002)(91956017)(76116006)(66946007)(66556008)(66446008)(83380400001)(8676002)(6486002)(53546011)(6506007)(6512007)(31686004)(186003)(6862004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE8yZ3lCcU9lS3duRnNFaklmUG5CVzVCdHpTbGtDaTdFVmxXeGU1amRibWk2?=
 =?utf-8?B?QUthVWVkcVUwaU9sRzVuaXZrZjdsc2d2Ui9zZUhyN0MxQVU4UGpKaWo2U1ZX?=
 =?utf-8?B?RlBwTnBZcURjWEc2UVpjQjF4V0xlcEFXQVVtSXBuRkxmWVlsTzU3cEY5L012?=
 =?utf-8?B?eEFMcjhEaXB3QmFsa0VPYnk3UkRva0pYQm4zSGxBOE1CV0psbXdMNUZJZVRx?=
 =?utf-8?B?ME5sbGpGbEgzajQ0c2VYZDUrVWczMUtZMnU2cXp4c1h6NnlGZmxaZXZaUis4?=
 =?utf-8?B?Y0pCZFY4bUlOS2JmOEhGWG5ReUNYaS94OXZSNDVuNTBGTm53dFFRUG5vQ3VF?=
 =?utf-8?B?VlBuYkpmd3pxazh5NjJ2Uis0dkpzeVJwT1pOdGJ1THRLclRtU1FlNFAyWGZt?=
 =?utf-8?B?M1c1NWMrYXAxQzRyRzNnWGZxQmxVbEtWaVkzaHZNNDNrK1VNN28vZGNnblBM?=
 =?utf-8?B?MzJkRXZ6Q0h2K0I0Z3hIdFNaYXJ4QW1DbVNBWG1nUC9OenBteWhKNVRYcytP?=
 =?utf-8?B?R1dYdVBYQklmUjZIYkUzcWcwSCt2L3lkOGlwUU0yVFV6Ylg1b0czRW5KcFRH?=
 =?utf-8?B?d0FGand1UEVwRHNGbTJaOW9sQnZSSG5HaTN3OUhldWlGYTdGWmZ3Y3dOcFYx?=
 =?utf-8?B?UENLdWtkVXdMRFk0eGxaNUNFaklyRlY5MzdjM21kcUd0cTFBdnNRZlVtUmln?=
 =?utf-8?B?dHp2ckliZW13dERvZXNOSnpIRHRQR21naUp4V1ZsR0VvTHFTV05HWWZRMmln?=
 =?utf-8?B?K3NLYjBCb25vb3orZW00SnhBaGR6TDRvaU9CSzlqL040bFNiOG55RitMOHFS?=
 =?utf-8?B?QyttYkdNSm16cWxla25KWmJLaFVJTjVoZUMvQ1k0ejR4VEpRL25WczUwWDlB?=
 =?utf-8?B?aWwrVnVJQ1NUUCtRNlFWa0V1MnJZVWt4N0dhYjNMOFNaNEZjNXYvK2RrVWR6?=
 =?utf-8?B?ZHNWb1d3eVFCRG9MTGo5U2U4RHAzWU1TYjNxYjArZS9mMTVORlllTjgzRWd5?=
 =?utf-8?B?RnhVWEszVFdwUGlNK2V2RnBMQlh4THhlYTdwNlQ4NjY4a0dFV3BnUDExZWJw?=
 =?utf-8?B?R25LOEZoVzhtODE0UU8yZWwyeTZtdWNndGxpL2tLVFpRZGNFOHcxUDQxYjVB?=
 =?utf-8?B?Tmd3cFBnUGhJaHFZeGR5a2Jzbm0xL2hwVXhtSFpzZFMyY0VKcVROQ1NUWWlw?=
 =?utf-8?B?eVQ0Qm9vbitkMUs1YlMvYzZNejJTR1BXOU4zTVpSWTVwcE1jVmJIdHZLQTNV?=
 =?utf-8?B?bWs4TlB2QlpkbnEramFxRWlDZE1xMjBEd0FNNEJ4UTY4R0ZmVU44Tm1FZnp1?=
 =?utf-8?B?QS9EaTBLY3BWcE1hUEtSRG1HSWN6NkREYkVpK3NDSEpGMGs5UnFMMEZpU2Jx?=
 =?utf-8?B?R0ZJa1pYTUVUbVljemdBNXZreFVBdmhKRlFJN05ucERWMDM0RkFsaDI3V01Z?=
 =?utf-8?B?WHpNZnJROUFKM3pJN05lNzhQK1VuVlBYcCt5TkhSMnB2WmdiQ0N6QXAyNlFk?=
 =?utf-8?B?UnNBcnIxdEtFSnVIcU0yMUNrclAxQ0dNbXFFVHozdDJ0ZHJaWjRLZFQvV1NH?=
 =?utf-8?B?QllJa1RGYlVNQkw2NlRpRHV1SzNqV2YzT2RqTDVhMFJwVXhzMitUWXdOOTB4?=
 =?utf-8?B?Q1kyd0F6K1dNZjBtSzh1OEJWMFNrUkZzYXBrb0xFZ1U2WThUUnRTTk9WU05U?=
 =?utf-8?B?Snh6TGdXdzdxdGZXNmRJbnVMcGgzNlh4VDhwaXZiOHUrQXNFcmZHZzlLaDVJ?=
 =?utf-8?B?c2hERmNmMVBCS2thUWlTVmhUNmt1d3hhRFlMR0xXVmhaZlVrZm1zcCs5UHBL?=
 =?utf-8?B?NnVLL0J3dzgrYTFKRVJFSWhHWHJjZDZlOGZWK2RnVHBsNUdJTHE1U3p4Q0hF?=
 =?utf-8?B?UFRMV0kyQm1xUDRNUVRhcHhlL1RHVlgxdTNneTFOWmRSWkI3SFgzN3NYSnVo?=
 =?utf-8?B?YnppVzlGcXQ0b0syZ05yeUFEa2h0VlQwTDdmUWdOcHNDU3FjK1RpNXlzMExS?=
 =?utf-8?B?b1EwN2NWSThzZnFHMHcyN3p2NlE3NzNwUjIwNlNDTTBEZ1hjcFdJYUVnYjhN?=
 =?utf-8?B?TEFMUUF3U0lTcDJHRWtCTXRhTldYeTRGeHBkREMwYTRhZzYreUtacnUwdXlz?=
 =?utf-8?B?anpZa2N0MFhxQ2IxTWFhYXErYkQ5Z25mbTBDZzBHMjNSTzR2TU5UQlUyd1hr?=
 =?utf-8?B?em5ESkJyZTdYV1FZaTJaYVhSWWlwNVY1VWZHeERwOEc1ZVduZW1hV3dSVDlx?=
 =?utf-8?Q?OD9LWHiftu/uUdQ1gCMzCQ60/8nOwLiz6tIRKTktcI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB58D445EC02604DA391E023008ED105@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uAUMGRy41TqibIzss/rMeoQbzNBpD8vAV1pFNXv5x3t8UcirXLl+J/C4SWswKDJngWv2JWCggfIjmwr8y7wTUaVhiA+cGGcj1fG3NOBCz10CYO4QAVqzST7FTgfjMUybAzoDui7OFnfguazm3zKRlF3A28eMDKIZKqK6FvFZZ800oIV9tJbFVTzeRSk/YxPhGAm61VoZELnz3Ba5v1Ofg3cRGpdJRVI1KpIOgENBlC9nrvB3mbnxOodDwf9mUEQjTZbG5nBfKtlLRdV1fasdkg35x66o5Kg5jna9RSJQ76eO5gDHHn2bRxzz2ja54hkg5QMFy1A1sG+9C/DqUlNtjlFjcDbkFyJ80ExSxHF0YZb0Ks2vWs0KIP9xjZkP1VmO7htzuXLxQTCL0vD17G6gRJqjSRD6MbgeDsRRU8MelBPmBRHXNhGs30kb1m1ZH7B+rNoCh/Otp9qtpyxzvpvMEF+wnz5KKYcn+IhRwSxrY0G9NOQmG3g3kLBm3nNwmvhGJBL4Tzp33Wk3YayQanYBjlF7GxCvm5Tp/lex76tRfvlsnEaNe0O7Snh00esvld89oM/8WoD3GCX09V2Ffikx4H9jYI0BrCbQ+tHSAyGs/EM8x8JV4OihdQLc/UvB2SbU4/WfkFh9UWuD9LMWcvFVBx94DWZ9zzP7CWrDg5ogGWu4tR85RIJDL2AZ4lDS0CAWXV3j5l1n27V65biAm2O6oZr34BEaAr93Pc74yktihGGiIwoNcmPbu9Qr61IljpEbBzyafhZZRpOIiuXld3oFKxEZG2YIG01U1vDSLn1Dd+XFfwnHvUkshjtjLjoSrIRv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f4573b-f02c-4a28-c2f9-08db1648c166
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 09:23:14.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAF5HBsO5Krsod42zAS6SbF/cISMaUxydb6o+jXFscwxK248zBZ49jgIrkKkDwC8mdTpXhINPPgJ3WcFalqOusjmUAOJa9aGvLa3OkliX+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8197
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDIuMjMgMDg6MjYsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gT24gVGh1LCBGZWIgMjMs
IDIwMjMgYXQgMDc6NDA6MzVBTSAtMDgwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
X3JlcXVpcmVfc2NyYXRjaF9kZXZfcG9vbCgpIHplcm9zIHRoZSBmaXJzdCAxMDAgc2VjdG9ycyBv
ZiBlYWNoIGRldmljZSB0bw0KPj4gY2xlYXIgZXZlbnR1YWwgcmVtYWlucyBvZiBvbGRlciBmaWxl
c3lzdGVtcy4NCj4+DQo+PiBPbiB6b25lZCBkZXZpY2VzIHRoaXMgY3JlYXRlcyBhbGwgc29ydHMg
b2YgcHJvYmxlbXMsIHNvIGp1c3Qgc2tpcCB0aGUNCj4+IGNsZWFyaW5nIHRoZXJlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQo+PiAtLS0NCj4+ICBjb21tb24vcmMgfCA0ICsrKy0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Nv
bW1vbi9yYyBiL2NvbW1vbi9yYw0KPj4gaW5kZXggNjU0NzMwYjIxZWFkLi5kNzYzNTAxYmUyYjIg
MTAwNjQ0DQo+PiAtLS0gYS9jb21tb24vcmMNCj4+ICsrKyBiL2NvbW1vbi9yYw0KPj4gQEAgLTM0
NjEsNyArMzQ2MSw5IEBAIF9yZXF1aXJlX3NjcmF0Y2hfZGV2X3Bvb2woKQ0KPj4gIAkJZmkNCj4+
ICAJCSMgdG8gaGVscCBiZXR0ZXIgZGVidWcgd2hlbiBzb21ldGhpbmcgZmFpbHMsIHdlIHJlbW92
ZQ0KPj4gIAkJIyB0cmFjZXMgb2YgcHJldmlvdXMgYnRyZnMgRlMgb24gdGhlIGRldi4NCj4+IC0J
CWRkIGlmPS9kZXYvemVybyBvZj0kaSBicz00MDk2IGNvdW50PTEwMCA+IC9kZXYvbnVsbCAyPiYx
DQo+PiArCQlpZiBbICJgX3pvbmVfdHlwZSAiJGkiYCIgPSAibm9uZSIgXTsgdGhlbg0KPj4gKwkJ
CWRkIGlmPS9kZXYvemVybyBvZj0kaSBicz00MDk2IGNvdW50PTEwMCA+IC9kZXYvbnVsbCAyPiYx
DQo+PiArCQlmaQ0KPiANCj4gSG93IGFib3V0IHJlc2V0dGluZyB0aGUgZmlyc3QgdHdvIHpvbmVz
IG9uIHRoZSB6b25lZCBkZXZpY2UgY2FzZT8NCj4gDQoNCnllcCB0aGF0IGNvdWxkIHdvcmsuDQoN
Cg==
