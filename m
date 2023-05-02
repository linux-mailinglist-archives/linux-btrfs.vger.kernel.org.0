Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA66F43EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjEBMfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjEBMfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:35:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6F2735
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030905; x=1714566905;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dd41S1Rf1UTVYCMiqHYTR7oFw5CC+/RuMY/nJ92z/xU=;
  b=E9IIJxrHUMOIiovHiJliXxZ3Jh2n8AyK+LBhzFvWh0FjIXRJvMzCgENI
   m9gO2O63dLnKhOSd/4EChQx+IllAm2mwhg5peD016kxcIvpj74JYbwbbf
   Dkl5Mpfd9omy3nSUjA7GofVsyCNhcExIZ36jRKNAgbOZVOJeISi67Sihu
   NLNj/tzRpDJ5b03CHJGubPNurmQPaGZmU4MJsBWiBMTA+XINpOsn2cu41
   +6wKhlzVEAe/DQdGGWx3MpE1Rpq0C//WdZAF2pFGXPMXc9qNNWMhZsHvw
   zFuvnxOktD+xfsg0pwJRhbn9K7rFZtJo/xUAHMX5c8sbW/6DtD8iiD19n
   g==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229605961"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:35:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nvu/Y2SMfSXLTUQwu06CeojZk68w3kHuFc3BUcEgTe+0aEnn4E97rNMSWZMsW3W/F8TWXrNEp7In7E1rcR7SeK6dsA3Iiy0i/JpUJeGJaGNq06y+8LzKohaxsdDdGgffXI8U1qE/8ICH8I1bCcFneb0yhvp9FlrRGMR764dpY0GSCAbxOIKdjrpThOskZU1JBXiaLQDXEMWpR1jn39M3ulpGy4ybXjeDO+Uz+wkTq7kskvM+lIUml1Fa6Fztu6aALJSPpF0/CxCtsTiMS/1ECodguIxx8I5yNRIfetY7MQnm7+WbHGRS7Rv4gUBVEKT3mPvQoQ+S+1d1okAwPNUOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd41S1Rf1UTVYCMiqHYTR7oFw5CC+/RuMY/nJ92z/xU=;
 b=SKWFebghudtzYbIWWeQxhnEX9ULF6nhqYrg18baOKox5I67InLkf0zvg04uA4J9THaAY8kcGgIx+UGDnUSTEkChg2UNyxG28HcOgY7VdzImylbayKnw9nmUL6Gh/IlwDjQLF2Pb96cgYkLD9HpJ+T3WoYaqZpfhMPabrDIb8sEiHU5GaIDXn/Aj8wzmKtHrBagXHj77Ag1BF17OrnKgs06hO0OGt0SS6F3V8O+jnOn5lwlndcJMppxM6LjWI39Ep/1ZcTkgsvf2shh0IF0CyL+q3igYMJcHBSP3uOjvo5rAcs8eUhcY0RU1I8PlVQm0T4WTxOT/UVkzowxKhVAuFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd41S1Rf1UTVYCMiqHYTR7oFw5CC+/RuMY/nJ92z/xU=;
 b=qg2H728txE9JTlhH7bpE+AWgR7W/Pkdzu1ZVpGMaPSr0M7NfVESasDsZhfX291uSFtmHjB7BnpHtnhbiRirAsmmgWk91yP666Bi3Fk7Kv5b+jzYsMfm4tDKV25nrAfUwNXZFscfGKfp1vgn2zEo/8saoXuFf7TTTOlR9fEcaN30=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Tue, 2 May
 2023 12:35:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:35:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 12/12] btrfs: rename del_ptr -> btrfs_del_ptr and export
 it
Thread-Topic: [PATCH 12/12] btrfs: rename del_ptr -> btrfs_del_ptr and export
 it
Thread-Index: AQHZetZPSeOClt2vpk+6DXq+4IKPAK9G71mA
Date:   Tue, 2 May 2023 12:35:01 +0000
Message-ID: <af99d8da-e451-302a-1803-59766a315976@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <7d772d80cffccb4054b74abd90649e1c4350a361.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <7d772d80cffccb4054b74abd90649e1c4350a361.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6298:EE_
x-ms-office365-filtering-correlation-id: 349c9290-48e9-4417-cc9a-08db4b09a638
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01Y/6vm7Stq3vv3D5SxoYZTo4YwCvdyYbQ3vNNUMig6c7ZquXK3/C5i4spjsN3lNqWJvaqf9jJ0he4c3Cqu5/mNZhfheRBQGRn3Ht4DVqWL1pOdhx21BWPDWPeiWjE50bVgXJWthV1tb7qWezOu2kdXYD6YVfe1a8HkuN03uxaatEjWzri5X8FAWFyah9V/8usOCP/LHGSTjtLpPlno0h/xwpWEGP1+CIrK/V1aMDuAR3dCHgpHoFzHeAY3ud8D9RjWrVKnG6VSJUOV/R5CYb/aaZuZGUFtY+NQ2g31aD8/BVQz1KXojiXqr70hkyuvPUR+lRfL28ablOnpGsrsgPbQtrVzGcgieMtiXjlfpTEMJDGkq+VKPA0og/P0rM8iOUAkduhHijSJ29E5XLSPhFrrBkLXM+zdjfsiFf0+kjEGsM3W3mJRlWK3X2kOnqCIp2wiGeCILKoMtGp00Rbc3yGFre+rLVQhjTJ4xs7YXtbPSSgHKwKZQIV2/bwtN0I7hroYgCsqoXMS5lyKMM3Qkr2I6G61xWa2fUGfKE/FlDf752N0RJWVUhKUcGo/j7J/+ubwgHACVUaIFmsrzU6hzkO9rPMKNks35ySurKZ39BdZ+TbDArvMbWF9KjIgY3Ij/8tixMlmz8twYvbLfMuD/PJ7pjaBuVCWhgrOZeA7yp1XvCyWHXidMOSoabdFpFn4i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(478600001)(186003)(36756003)(6512007)(2616005)(53546011)(31686004)(71200400001)(6486002)(316002)(110136005)(6506007)(83380400001)(91956017)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(8936002)(41300700001)(2906002)(5660300002)(8676002)(122000001)(82960400001)(38100700002)(86362001)(31696002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUlHMFA3U2gyYjM2MDZONFZ5UTFxT2N3S0FtVDgwMGdqNERTR2wyUTFKTFNH?=
 =?utf-8?B?RWNzbWpCRWJ0RW9aNG0wb1JRQWRFelpGcEprN01ydTRMYmFvdGNOcW1odHVk?=
 =?utf-8?B?Ti9vditXY0s3ZmplZWVrdXB0RkIzYUpkdzZMa3FISVB0enMyTkFtQjFIY3lS?=
 =?utf-8?B?Vk5wNW1mU0JMbndBV2NFblU2R2QvdmwyVTRPUk00dkJWeTRZeUZZREdOZWl1?=
 =?utf-8?B?V1pkTy95bHNlT3gxc0pUanJWN3M5WnRtSkwzYUtQREgwMjJPa3laaElYdVZh?=
 =?utf-8?B?cFlZbEF0Tit1aFlldGhMTGtBaVBMSTRKSzdmdVA5TkxXTGd0cGxTc2pFVytH?=
 =?utf-8?B?dmt5M3FKWFlyNndLVHY5YmZpR1dQTXUxelN4VlpwNnhtTlZQd0FCTWJ6cFp1?=
 =?utf-8?B?Wng2aWZ5T0puTmgyVnZuNGU1bzhYdnZUbyt3VEwyVXdxVFZSWE1rWWpQNTN4?=
 =?utf-8?B?OWdVUkNKMlRuRG9lL0V2MkRtZjQ1WDk2SjM4NkcxVkZ3a041ZFo1ZW5wTVcx?=
 =?utf-8?B?by9Yd29HQ05KSmMyQVZGRnFWRk93Y2YvQVI2aDRVZ1BnSXdSb0lEeXB3Rjlz?=
 =?utf-8?B?NWFOTEEyUEllRW0vWWxoYlJLa1c0d2EzY0hXU1lkbUVoYlNEeWhQbi9BZytY?=
 =?utf-8?B?eFdjbDVOdUp5ZFBFbXRiQUtYSGNweXRPR08yN0pobk1yRWM3VXZXYWtqMUpR?=
 =?utf-8?B?L2I1NFJtdmxTQWhvK3FWUnhkbmdiRXhaaTNmRXIwbzZwMlRFVE9DM3ZHeVNu?=
 =?utf-8?B?TkRCU0NYV2c5Y1FibUMrVUwxTGJIbW9OSGNUczBUY3cxUnNsNjJzTEFtYS9l?=
 =?utf-8?B?d1FhTFF6T1graFc5WFdJOXNtZXhXRlhDTHIxMkJWRjVWMHY4Szh2TjZoQ01H?=
 =?utf-8?B?TitYdFRabVBYWXQxTnRzUGRidzdWY2FMb2t1b2dYOTZaVG80N1JwZEVOYnQ3?=
 =?utf-8?B?U2pMbUthbEJXRUFYZ01NbHRtL20vL3JOenowRWtPWlpFUkNqaGlQWmU1bXN1?=
 =?utf-8?B?bFpmdmhxNmY1OXpKVHM1OWU2aElLYzd2WGJrWEtnMW1BZDhsTUNLRjdBaG03?=
 =?utf-8?B?Uml5aktPTEhTVjltcFpsV1RTL3RzWnIvbCt3T05ybnZZRlljWHIvSXpZejQ1?=
 =?utf-8?B?YXBIU0hRVCtVdnpHZFlrOThxeDUyS0JBbTNWbHNxaUE2bjdvaEhwaE9VWktx?=
 =?utf-8?B?SkZEQmgzU1EwSUoxc29LTkJxajdlcTlvdFU5R1NLekZRVGt4b0Q3TmVBcDBT?=
 =?utf-8?B?OThOcTM2YTVRd3drYmR4QVgrbUxOOW1seTdMdnFVaklEK2hYQ0REdmVMeEl4?=
 =?utf-8?B?anJ6emZNM3pPdUgyYXBETnlWbWtCcGlBWk9nQlRqN1pKVVIrdlcxOHRMVFJN?=
 =?utf-8?B?NjM2Mm5QUVZBQXZtckEvaWNUZm1Bd1RZZDFMRlUwdjh2M0F3eHJDanM1clUw?=
 =?utf-8?B?OGNyejljdG90Z0xNK0dVQ0JXeVhHblpmT2JlWUdsVG1laGFzblRsaElGSmdX?=
 =?utf-8?B?Z29XMTVBNGMvSUNwd0JJV1J4N28zUno0VGg4QlBjRnNscHlUMkVtM0JrNGND?=
 =?utf-8?B?ajRNMU0xUFVueW10V3JWaTVFUElRSUxuSWw5enBkOHFyR3p5eVptVzdEcS9X?=
 =?utf-8?B?ZEh1QWs3b1psU0FrZ3NqZ2RRRllqSnJxUlY2NTZPaDBSZmVuZDVPQ0tjN2dX?=
 =?utf-8?B?Szlwa1JycG93VzM0VTYrcWN3anl3cGN6UHZqeXpHT284R3MydTBrQkF4Q0VM?=
 =?utf-8?B?S0JvRmhvbjd1ajU3R0JYUDFXWHd0b0VZZ3dqYmU5WWJNVXBlZnR5K2g3MjVm?=
 =?utf-8?B?NmZFSUxzQTZUM1R6MTlrTUZMOVBadmxjUUY1Vk1mdzBOZ012SVVDR1l3dUdq?=
 =?utf-8?B?STVycDIyYkZyOUxuZDNiKzh2RUtweXpTMTliTzhoRWQxdEg0RzJYRzVnZTkx?=
 =?utf-8?B?ZEJ4Y0daSmtqaTdnMm03VUkyV3ZrdXhxTjdEdmpYM0JKd01xWENEamZ2VUVI?=
 =?utf-8?B?cENTdWF2ODM4Q1RIYy9DN2JxRWk1ekMyY3YvQ2FIS2JjSXVjVUQ4ZHFPaVhY?=
 =?utf-8?B?QVYvOUtvRWNzQXBmZmwzNEYzdHVqWFR3Y1UrRWFFVmxPTVNnZkVDUXJSS05M?=
 =?utf-8?B?dWE3b25CK0RnelQvbWNORmVpclpiYlNuTzJGWnUraUQ4ZGFWMmkrMUt0Qnp0?=
 =?utf-8?B?eEVWVEQ3TTc0aG16blVlQkRZaW91Z2NhNEVCRzhId3ZrV0hwdWIwRkpIcDRI?=
 =?utf-8?Q?b73mc8js7bb+cWPpFjdNagiGM1l7uuORtZBZLBmed4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CBE9F41D950894D9B7AEB7EBE2AB1CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4V1NPi2vsCKN6eU2hr0/HW26ojhJUqN4jrMbIgR+G1TsaAQX3y3A/a+Vp15IJKmzDlRCKWmwXgeRbp5JX1bJno0WpGRdUXKLMjO5e/8Slw9l/sbQKO9edRMgMSdqE0mwlw9qOYBZA0j5SsGsk6pUO6TJsUz4rQ7bUmXyy8VE8xdKViBquUBDrQGkDqvgTr4Xvpp//putOh95v47JeZkKyXAbKhmzOQ4UtZxDm8wpGgoOz1JY8Q+1JTqEJdE2VwWIszG105rbYw+OjTOxzvbYuGnm1sbHOxIIE6IRYW/uaZTqOVCQWzFrtlTUnE3OgzlTJ9DctpyNWhMtxXmwhQfRIKjGiXE5ZhOlyBEqtW91CLc+Xw3A4zHK/62umTPrtxJmEm5o2He3BPfM2F+j/1rAlYTv3Wnzr8+C2OZ4SUPrLhJ3chaGEi7VszAzxZwacwYXtPK3cNuLG8GsgiUyok+fZ8wTAONKsfmVxukfHZm6q1DDU/tJ+/zdRPA8iWI5KX3TW2RMVrr0Ej3rTpfC/YUbN9eYadWxLMRq+AG3dxc3PFDQIFbOnF165Cv4tJ3Fa0XKEPy+Ct3tcOB1hXabB6n1yD1V11DuhMc3X3mHv4BLMdZv52cgeLhg0M0GwBSr4H9eaZYPTTWjZE5FYHb16eyRLxjFViy5r9dz6kwJ0bVZ+6ZVPmbli63guynKX989UbeSOw5uG9UN0YijNHdIVTwqVCDnHVL37hJ7ToRTFjU4+3NpArKYutD6qbdDU41Rgs6TFa9Yaz1T13CtEsG+DAuuuWLwr1os8fo9/R9gy6lPXqcM6I4XAHdm6pSkNooAkrD+LAASik5SLu1DdDsGeTu8Ag==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349c9290-48e9-4417-cc9a-08db4b09a638
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:35:01.8283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzYT+IQnp9FYDtjAuW/TQtGt3kfC22dnvhQnL+io3ZfXZ8Md5gBAf23u9nABFdMJwaG54TaI0A/eCv3nkfjLkyWdMsy3oZQsHei02+VlICo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDQuMjMgMjI6MDgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBUaGlzIGV4aXN0cyBpbnRl
cm5hbCB0byBjdHJlZS5jLCBob3dldmVyIGJ0cmZzIGNoZWNrIG5lZWRzIHRvIHVzZSBpdCBmb3IN
Cj4gc29tZSBvZiBpdHMgb3BlcmF0aW9ucy4gIEknZCByYXRoZXIgbm90IGR1cGxpY2F0ZSB0aGF0
IGNvZGUgaW5zaWRlIG9mDQo+IGJ0cmZzIGNoZWNrIGFzIHRoaXMgaXMgbG93IGxldmVsIGFuZCBJ
IHdhbnQgdG8ga2VlcCB0aGlzIGNvZGUgaW4gb25lDQo+IHBsYWNlLCBzbyByZW5hbWUgdGhlIGZ1
bmN0aW9uIHRvIGJ0cmZzX2RlbF9wdHIgYW5kIGV4cG9ydCBpdCBzbyB0aGF0IGl0DQo+IGNhbiBi
ZSB1c2VkIGluc2lkZSBvZiBidHJmcy1wcm9ncyBzYWZlbHkuICBBZGQgYSBjb21tZW50IHRvIG1h
a2Ugc3VyZQ0KPiB0aGlzIGRvZXNuJ3QgZ2V0IHJlbW92ZWQgYnkgYSBmdXR1cmUgY2xlYW51cC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4N
Cj4gLS0tDQo+ICBmcy9idHJmcy9jdHJlZS5jIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAgZnMv
YnRyZnMvY3RyZWUuaCB8ICAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvY3RyZWUuYyBi
L2ZzL2J0cmZzL2N0cmVlLmMNCj4gaW5kZXggYzk1YzYyYmFlZjNlLi4xOTg3NzM1MDNjZmQgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2N0cmVlLmMNCj4gKysrIGIvZnMvYnRyZnMvY3RyZWUuYw0K
PiBAQCAtMzcsOCArMzcsNiBAQCBzdGF0aWMgaW50IHB1c2hfbm9kZV9sZWZ0KHN0cnVjdCBidHJm
c190cmFuc19oYW5kbGUgKnRyYW5zLA0KPiAgc3RhdGljIGludCBiYWxhbmNlX25vZGVfcmlnaHQo
c3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+ICAJCQkgICAgICBzdHJ1Y3QgZXh0
ZW50X2J1ZmZlciAqZHN0X2J1ZiwNCj4gIAkJCSAgICAgIHN0cnVjdCBleHRlbnRfYnVmZmVyICpz
cmNfYnVmKTsNCj4gLXN0YXRpYyB2b2lkIGRlbF9wdHIoc3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3Qs
IHN0cnVjdCBidHJmc19wYXRoICpwYXRoLA0KPiAtCQkgICAgaW50IGxldmVsLCBpbnQgc2xvdCk7
DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRyZnNfY3N1bXMgew0KPiAgCXUxNgkJc2l6
ZTsNCj4gQEAgLTExMjIsNyArMTEyMCw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQgYmFsYW5jZV9s
ZXZlbChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4gIAkJaWYgKGJ0cmZzX2hl
YWRlcl9ucml0ZW1zKHJpZ2h0KSA9PSAwKSB7DQo+ICAJCQlidHJmc19jbGVhcl9idWZmZXJfZGly
dHkodHJhbnMsIHJpZ2h0KTsNCj4gIAkJCWJ0cmZzX3RyZWVfdW5sb2NrKHJpZ2h0KTsNCj4gLQkJ
CWRlbF9wdHIocm9vdCwgcGF0aCwgbGV2ZWwgKyAxLCBwc2xvdCArIDEpOw0KPiArCQkJYnRyZnNf
ZGVsX3B0cihyb290LCBwYXRoLCBsZXZlbCArIDEsIHBzbG90ICsgMSk7DQo+ICAJCQlyb290X3N1
Yl91c2VkKHJvb3QsIHJpZ2h0LT5sZW4pOw0KPiAgCQkJYnRyZnNfZnJlZV90cmVlX2Jsb2NrKHRy
YW5zLCBidHJmc19yb290X2lkKHJvb3QpLCByaWdodCwNCj4gIAkJCQkJICAgICAgMCwgMSk7DQo+
IEBAIC0xMTY4LDcgKzExNjYsNyBAQCBzdGF0aWMgbm9pbmxpbmUgaW50IGJhbGFuY2VfbGV2ZWwo
c3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+ICAJaWYgKGJ0cmZzX2hlYWRlcl9u
cml0ZW1zKG1pZCkgPT0gMCkgew0KPiAgCQlidHJmc19jbGVhcl9idWZmZXJfZGlydHkodHJhbnMs
IG1pZCk7DQo+ICAJCWJ0cmZzX3RyZWVfdW5sb2NrKG1pZCk7DQo+IC0JCWRlbF9wdHIocm9vdCwg
cGF0aCwgbGV2ZWwgKyAxLCBwc2xvdCk7DQo+ICsJCWJ0cmZzX2RlbF9wdHIocm9vdCwgcGF0aCwg
bGV2ZWwgKyAxLCBwc2xvdCk7DQo+ICAJCXJvb3Rfc3ViX3VzZWQocm9vdCwgbWlkLT5sZW4pOw0K
PiAgCQlidHJmc19mcmVlX3RyZWVfYmxvY2sodHJhbnMsIGJ0cmZzX3Jvb3RfaWQocm9vdCksIG1p
ZCwgMCwgMSk7DQo+ICAJCWZyZWVfZXh0ZW50X2J1ZmZlcl9zdGFsZShtaWQpOw0KPiBAQCAtNDI3
Niw5ICs0Mjc0LDExIEBAIGludCBidHJmc19kdXBsaWNhdGVfaXRlbShzdHJ1Y3QgYnRyZnNfdHJh
bnNfaGFuZGxlICp0cmFucywNCj4gICAqDQo+ICAgKiB0aGUgdHJlZSBzaG91bGQgaGF2ZSBiZWVu
IHByZXZpb3VzbHkgYmFsYW5jZWQgc28gdGhlIGRlbGV0aW9uIGRvZXMgbm90DQo+ICAgKiBlbXB0
eSBhIG5vZGUuDQo+ICsgKg0KPiArICogVGhpcyBpcyBleHBvcnRlZCBmb3IgdXNlIGluc2lkZSBi
dHJmcy1wcm9ncywgZG9uJ3QgdW4tZXhwb3J0IGl0Lg0KPiAgICovDQo+IC1zdGF0aWMgdm9pZCBk
ZWxfcHRyKHN0cnVjdCBidHJmc19yb290ICpyb290LCBzdHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aCwN
Cj4gLQkJICAgIGludCBsZXZlbCwgaW50IHNsb3QpDQo+ICt2b2lkIGJ0cmZzX2RlbF9wdHIoc3Ry
dWN0IGJ0cmZzX3Jvb3QgKnJvb3QsIHN0cnVjdCBidHJmc19wYXRoICpwYXRoLCBpbnQgbGV2ZWws
DQo+ICsJCSAgIGludCBzbG90KQ0KPiAgew0KPiAgCXN0cnVjdCBleHRlbnRfYnVmZmVyICpwYXJl
bnQgPSBwYXRoLT5ub2Rlc1tsZXZlbF07DQo+ICAJdTMyIG5yaXRlbXM7DQo+IEBAIC00MzMzLDcg
KzQzMzMsNyBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBidHJmc19kZWxfbGVhZihzdHJ1Y3QgYnRy
ZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4gIAkJCQkgICAgc3RydWN0IGV4dGVudF9idWZmZXIg
KmxlYWYpDQo+ICB7DQo+ICAJV0FSTl9PTihidHJmc19oZWFkZXJfZ2VuZXJhdGlvbihsZWFmKSAh
PSB0cmFucy0+dHJhbnNpZCk7DQo+IC0JZGVsX3B0cihyb290LCBwYXRoLCAxLCBwYXRoLT5zbG90
c1sxXSk7DQo+ICsJYnRyZnNfZGVsX3B0cihyb290LCBwYXRoLCAxLCBwYXRoLT5zbG90c1sxXSk7
DQo+ICANCj4gIAkvKg0KPiAgCSAqIGJ0cmZzX2ZyZWVfZXh0ZW50IGlzIGV4cGVuc2l2ZSwgd2Ug
d2FudCB0byBtYWtlIHN1cmUgd2UNCj4gQEAgLTQ0MTksNyArNDQxOSw3IEBAIGludCBidHJmc19k
ZWxfaXRlbXMoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsIHN0cnVjdCBidHJmc19y
b290ICpyb290LA0KPiAgDQo+ICAJCQkvKiBwdXNoX2xlYWZfbGVmdCBmaXhlcyB0aGUgcGF0aC4N
Cj4gIAkJCSAqIG1ha2Ugc3VyZSB0aGUgcGF0aCBzdGlsbCBwb2ludHMgdG8gb3VyIGxlYWYNCj4g
LQkJCSAqIGZvciBwb3NzaWJsZSBjYWxsIHRvIGRlbF9wdHIgYmVsb3cNCj4gKwkJCSAqIGZvciBw
b3NzaWJsZSBjYWxsIHRvIGJ0cmZzX2RlbF9wdHIgYmVsb3cNCj4gIAkJCSAqLw0KPiAgCQkJc2xv
dCA9IHBhdGgtPnNsb3RzWzFdOw0KPiAgCQkJYXRvbWljX2luYygmbGVhZi0+cmVmcyk7DQo+IGRp
ZmYgLS1naXQgYS9mcy9idHJmcy9jdHJlZS5oIGIvZnMvYnRyZnMvY3RyZWUuaA0KPiBpbmRleCAy
MjFlMjMwNzg3ZTMuLjlkYzkzMTVjMmJmYSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvY3RyZWUu
aA0KPiArKysgYi9mcy9idHJmcy9jdHJlZS5oDQo+IEBAIC01NDEsNiArNTQxLDggQEAgaW50IGJ0
cmZzX2NvcHlfcm9vdChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4gIAkJICAg
ICAgc3RydWN0IGV4dGVudF9idWZmZXIgKipjb3dfcmV0LCB1NjQgbmV3X3Jvb3Rfb2JqZWN0aWQp
Ow0KPiAgaW50IGJ0cmZzX2Jsb2NrX2Nhbl9iZV9zaGFyZWQoc3RydWN0IGJ0cmZzX3Jvb3QgKnJv
b3QsDQo+ICAJCQkgICAgICBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqYnVmKTsNCj4gK3ZvaWQgYnRy
ZnNfZGVsX3B0cihzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwgc3RydWN0IGJ0cmZzX3BhdGggKnBh
dGgsIGludCBsZXZlbCwNCj4gKwkJICAgaW50IHNsb3QpOw0KPiAgdm9pZCBidHJmc19leHRlbmRf
aXRlbShzdHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aCwgdTMyIGRhdGFfc2l6ZSk7DQo+ICB2b2lkIGJ0
cmZzX3RydW5jYXRlX2l0ZW0oc3RydWN0IGJ0cmZzX3BhdGggKnBhdGgsIHUzMiBuZXdfc2l6ZSwg
aW50IGZyb21fZW5kKTsNCj4gIGludCBidHJmc19zcGxpdF9pdGVtKHN0cnVjdCBidHJmc190cmFu
c19oYW5kbGUgKnRyYW5zLA0KDQpBbmQgaGVyZSBhZ2Fpbi4NCg0KVGhhbmtzLA0KCUpvaGFubmVz
DQo=
