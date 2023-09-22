Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E57AB225
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIVMau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjIVMat (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:30:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018B122
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695385843; x=1726921843;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=GRpKLn+nw2jKIBGNRCjbUdoFtqhneUTyzG7Ro5FWKFxJPcE9bdqUJW2f
   EhV6tGgqfJiBWYxX0uyEKg9QDh+DjRPmdkSno4i21uZrXDYgUxKCGkUtU
   SzAZmCSrc7mZr4MveioSK+/wzby0uFekL2oONS37eMtoyd5i4r/IUXp1Z
   3m3CT3d+zlB1OQYxuAC9oLXJbUMNJsSkAYWTgD8xQioEXNoO/fDx9F70J
   F4CXOR3KiVUi+lsXzZHslB+q0M5DMUtwE5iVkpaqTnH3bQm7r0+0tLYV6
   hrI6tBdXZkla35lfW8wI/gdKwklBmtcyFu1CgbMeCo40nseHIntPFcxCf
   g==;
X-CSE-ConnectionGUID: SuKscHEKS8641kkmewVKfg==
X-CSE-MsgGUID: ACyC1M4dRu2wVuUq0enipA==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="242821899"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:30:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCdO/gnD7pxp7eRoYQ0XJoJodBqSWcGepQXFCoMwEIEOaEZJus8a4sypBrdlXP1Dc8+SPXbebkPuCQ9a0Lu2uaXolx/Ien1zrd5A1JsPbgbCjWOneRR51QVk+onajX3PH21BDjZzatm+FJwF9+quuAHPEHVyQBj8G/xhfwlpLU8VxMyRjOps8PUhYvwVxSAuQgq7XtEyRj1IzzQxh6TPziSvuwdRGpoMsqV0mviMBqwkVYytSGWwSOzDJ1iClCLW+mdKLFJP/9tTQED6QLQeayA0jrMv0ZiVsLusds829R52c9mQwHnjYUZnPDnPCNYHyoQhnZ1nNPmafc765a5syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=T+EzeGRDY9l8Hn3jbYBKQ6ZqxEBw2FYcsPdPKA1iB/oiYKuCl2wz8TzZe9Yz/C+x9nem1mP+6M8ty6w3qt6wV3YJjlu2IBQWvK2KcNvT7Rls7r6IYqhwn11beQrETP6V+6BsMS7veyV476u82dzC9i+I9MWvceIQE1iow2QER/V/gYyXTBm6vDTlxNJm0QeoTodYOeN4wyFTAc3wWpuEapj94uNjyLFZw0aYFDOcDjDaqQsmrEilkRcAWxiyRBz7VSrOV7YKW/h9WZLFcBy95THuHTiMK3Gdqlvg9gwB6LBgy0c06zI7eIBfO597uN5do+2wHcc6Hrbmt9HUvPKw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=0Cy/mWKrYS6ISbFiDofLkixX7lYrauWHajDHM/Ly2rS5H8BAyacTrTLTNMzT8Q4AgBuZJ/GjhTtO2G1x6rhwcABTqou5pfdTjaAy57mOo8BIsAyYhMXJ6/yMxfULpffPOSKTtfSqeehDY1gBv4/legVNw1dAlthiei9Mq0ZZdaA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Fri, 22 Sep
 2023 12:30:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:30:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: relocation: switch bitfields to bool in
 reloc_control
Thread-Topic: [PATCH 3/8] btrfs: relocation: switch bitfields to bool in
 reloc_control
Thread-Index: AQHZ7UXncjO3mwNjVUyUAlNbOcVu6LAmxqSA
Date:   Fri, 22 Sep 2023 12:30:39 +0000
Message-ID: <f349a296-7cd3-4620-8b14-c8255486e352@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <28dd578b57ecb9270fe60b2170b4cac5c1ad77bf.1695380646.git.dsterba@suse.com>
In-Reply-To: <28dd578b57ecb9270fe60b2170b4cac5c1ad77bf.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: 151424bd-80db-433c-0434-08dbbb67bae6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efLYH9vnKLDBQn8uANpd/qwjO3LAbY9NYB0bCLenFq6cINHpuWHJa5YsX1+UMdf1zfn2zLCb8b9psK7qk6enrb4+C8goms4XcQxNvapJAKchV4B+huXW4ONMgXBwGU9Qafk8qzMO/Vp/Sniu24f57loQJhl8aZm99PqL34C4zPZtmwC4VDq349cP7vQks9h3UDugr2m7WKgEVl2d8mxY/A3HoLaIPTnZHfALPcUtp+JFdePwtbXoDHn+3ZfZ/5ZivA2DcFf05xYUVraa7CbbdY2L8M3VrduQh6IHygaaVibN7lvVjvTFPfGRMK907Mv7qwKfK0OxBf2jxn70fWWhT93mxXDuq/4q00Q0uXQBX9tw0KqBS3rRshLk0zAQL/oWZ1Gx7XB4J90AVvpZv2IVWz+mlufCQa1vyygyFiuP/RhKpmYH+/IlXXfo8nCPDdZ+QsxcHj/weOEQB0ooLLTjQ7MF9p2iDjRyCrlcEKdHMcelVh7VQfAPFksxr5LMgPbZ0mixXj8BAGKK/F32GjBL8erM8as/xS9+S0+PNcnoG6twle/COOrGKxjWV6x9Nt0NFcLG/koX6P4M8g2DNgzJ2fwSLZ4bcnPZBzn3Bd1ZHdkqFWS2FxgIoS+MnJyKTbIdjfU2I0xQrHFGqtEY29zQeUHSMajC0QxY66SzW1rgJUFQOnLJxWjpskrYaNF6ffSi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(31686004)(4270600006)(6506007)(86362001)(38100700002)(6512007)(66446008)(66556008)(76116006)(66946007)(41300700001)(38070700005)(66476007)(64756008)(91956017)(71200400001)(110136005)(478600001)(316002)(5660300002)(82960400001)(2616005)(8676002)(19618925003)(8936002)(26005)(558084003)(2906002)(31696002)(36756003)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFXOFlRMkhqaDZwb1JxZUJQQlF6bHg0QXlsN0ZqUTZTVEQwNHVYSWFhNmdH?=
 =?utf-8?B?dEkydGJrSFVaSjE3eWdKQlFQc0Y5dGRBTWVyMnMyZjh5NTdMUmw1WDVqVzdS?=
 =?utf-8?B?dVhxbGoyQzNhaS83MENINDBZZHVJcVlKdzBjQVZxZXFjVDM0bWFWRlA1SVdh?=
 =?utf-8?B?LzlDQTdaanpHRUtJMTJ1M0FhdDBTbThWZmhmUUx3KzRMSC9vaTV5WGRDU2lv?=
 =?utf-8?B?RW1ydWFkWU9xTjZmcm1abWFNU1NYejNYeGkzUWpvajNudU0yYnFjNDFMbjJK?=
 =?utf-8?B?TlVOQldaa3FLOE9OREhBM2Z5SEtHNVc4SFRCbHhxdDFrL01WcVYweHJxUDdE?=
 =?utf-8?B?OVpFQno4UFVrendTQ2xGTTF0Uzh4VTB0cWZFczJJUGFyVW16enByS1ZwUm1Q?=
 =?utf-8?B?T28zL2V0dlZ5MkxQaFd0ZUlxYnRIM0crWDFzUGNCdVFOczI0KzRUUENNYmtV?=
 =?utf-8?B?dllwT3V1aUFvczlQYytJLzFMYSswVGJ4MEp5cmJJNGhrYTg1OTJ2cnJ0amha?=
 =?utf-8?B?TFdYV2ZPNjBMd2JZaHpjbWgyTXhSTFVqT2I0dTFKaVR1a2Q2UU1XVU85N2hz?=
 =?utf-8?B?MUtOZVZiQ3hrRlZ2M2VCK09wMFRjd0NIVERPNVBER2hwL1Ywck1NM08vM2V0?=
 =?utf-8?B?RklYdjQ4cmt5bW5KbjlVUStoaU1mTjh4Sm1IOGYzeHBCeGVOUmZ0Z3V6TkpR?=
 =?utf-8?B?S3dvS3lvcVZ1Y0pSSmRCN3VaZEFYOENUOVZ4VWFNK05aREx6VlpldGl1TzhT?=
 =?utf-8?B?ZENLb3JCNjVjMmdtQkFTR1VuUkhlcWxVU2w0em9QYzVFdUlacytFMC9PWGdW?=
 =?utf-8?B?elNkTllFd2E4cFYvZnV2WlAwTlpDeWordGJLUHYzcjNTVk1jcWRoaGxTMlI4?=
 =?utf-8?B?RmU0bUlVamI5MVd1eU5wckgvUytOZWwvMTFITURhdmhaaitycE5YVUpBUEtr?=
 =?utf-8?B?N01jbm9GQVUyYWw2V2tDTDMrcnhiamRHSXhkaCtVbVQzMVdMODNjbC9UQ0hU?=
 =?utf-8?B?dURhQUMzZ1dFSDFxTXZ6aFZkaW5TYnRGb3NRcWo5YkorOWpqaTBxSHREWFlj?=
 =?utf-8?B?dDYxamhHOUp3d2hmbktMVm1FaHJnWDU3YkU3VTlyVnZUTmtiMy9PVWQwZ1lT?=
 =?utf-8?B?Y0NiNU9Eajd4ZWI0Z2JidVNZVkNXSDZGWFZ5UW8yR3NmTk1HZm5hczBEZDhB?=
 =?utf-8?B?bnpRZTBBUjJzbDVnY2dpb0ZUZitlTG1kSWdKYld0SnhtQ3JwTURNZThDaS9q?=
 =?utf-8?B?a1lCYXlFaDdjRTBTZkN1eTM4ditnbnNBbHJjdTBKUVVIdzJRb2p4KzkzU0xN?=
 =?utf-8?B?RlhyZWdoR2dDeG9uQVUvaVB3TTFWSzNuei9aM2hJY3JjS3AyU3FTWlVJOFE2?=
 =?utf-8?B?T1ZUM3MzRXpvZ2R3THhYeGRQVG05bmcwUVd4cmN0YUlCRWl1WGlwdHcrN3Ri?=
 =?utf-8?B?UG9ka1FpNU5qenlCaktjTnRKQXNVWlZVZWNJSERpTCtQNkJhNm1FQ2JJempl?=
 =?utf-8?B?NHd3VGRJUUpCUGdUSk5GS0VuQ3FPZG9YZGJMVlp4bkY4U3dHNUJwc0xCa1R3?=
 =?utf-8?B?OFlTeEp0Ulp4aEVZS1daNXZ1MWMxTUc3ZmhKRzRJMVJCbXlMSHpkeXZqY0F3?=
 =?utf-8?B?eW9qeEZaTUZUai9KckRpQUY1WU5iK0FMSHo3NEZ5YmlSazgyRmI0Y21GNlg1?=
 =?utf-8?B?Ti9UTXV1d1hWMzJReXFVRWpBV3Uwc2hkeUV5N0J1KzhtUUlheHNKNmdIbVR6?=
 =?utf-8?B?YUpmNmd3dkxwSGRnRTZ5Z0UxbllRc0Zwc0lKS2xpdVBMY253QnpNRzhjQVlO?=
 =?utf-8?B?NXh4eURNZEV6RnpQb1h6MmpYdjh6TVFtUUdrcHpRcTJacG1kMzYrZk4rVzA0?=
 =?utf-8?B?V1AwK0YrWWZONFR5K2RDRUJ2OG9ucFpWMFhqUXlDRmg2YkNqYjhqSUdIMEJv?=
 =?utf-8?B?K3FHRFBLUVB2SjFRWVFRdHdaeXhPUW9CZVFwZmJud0hON2VSdSt3MHVTWVlw?=
 =?utf-8?B?MkNyR0NkL3laOXcrMXF3TlFoMGV6emNoVkFNMkFaNHg1UUs2UUd3YXkrZnha?=
 =?utf-8?B?bEQydWpOYXVBeXhIMnl0aWtzaUl1d0hQSXgvdjkyck1LNi9HTVRVVFZDNms3?=
 =?utf-8?B?dlplNEt3Q1ZaOUFTWWtPT2QrR2NNVkI5bG1QUGZsUzFhM1VLS0pqeGhLNTd5?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F2664FF0794ED488357A4FBB7143AAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iRwdEY7bN6Zm6OrO7IqZGBZQtarv4YOr0cIinEhciyTZjxBbfO0vQ2acgGogPZ0fLUfLYkNksXZDnIXirS+n1ObVcdBy2AgQhalaXHm1XPX505uLiAwxwCeEUBVO/FML1CEOPmEU+JXKd4+1Q5bu4raNBq5SvGYQ2DGLB8Mk/jR2DWgrUnTqcSpCtRHXDUzU9OzIjkMtpBFZ9GXqw26Pw5FOJsloMBj20jyf78iepcab2y7tYpNIFCSeMwACmK+ZHJ8Y13YPO7cuIn7nvDAxZ+Db9QVFc/L9+JOtaO10JaIcsnBgnBXZNspsAUyIQK6h8GpbiEqfSDoPHKBlFy7PXVyER5YrLqLBjjfshIZz5sJIW9aRnEmj5fY+0bm+82JjNzLt4pMqgvkrfe9QM6DbZtGrn78IGSRFhv32Y4YtqMasBj8YbZdXd2J55dPbgUN79KEOjdXwcHWUn9aLJqYlcuuObzNTrEH55P2NZF94I4a/WN5WuFjwvHf0q/xRfuxjPci/R+xoVS5K0wSkNhGABIg2Soeb88ui3lZz3fqECX4Ta6PromaoktOa6tH/jNOd1oVs3bb0VMvS/e6WS456M8NfSAlQhtRJu7e6twDoUMCwNQR3S5oXvTvKPg3mLaTqx43wC8mIyD7s23AkkB794gzE/8D5jKCwv/2d2Qq0B4Kw2qf8302VUF8bzP15Oed9Dg5qqupFxnGLSk05GC088c/oXifwvw1Ocai9RuLqE3YUBTLhwrNxGt0LoiL5LxL8Pa8DOdsywbFwq4Pp7pvRLwmuLyK4UPXDT4SR3vlxPEDG7HeQ5aqiejFbtodNEOfS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151424bd-80db-433c-0434-08dbbb67bae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:30:39.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdqGHlqwGl6ioVgXsb56YeUv9YAb6QZ8wifKTLVUx+UJFNFBR8nbkUXEb32Gywqjb2kDWT2DGQ+FmcabN9Bk4t+xTHlmckbohx46xHtT+/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
