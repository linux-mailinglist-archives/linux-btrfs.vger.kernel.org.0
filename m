Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D671844A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjEaOJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjEaOJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 10:09:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3B359C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685541908; x=1717077908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O17/xsk8C5zZWTfs1useH92ayZda7bcosEo47RH9tgg=;
  b=VgGFE18be/qSFnQneTSG45F/eutsfSveLpHakVitAaD91k/jUeGvOL/Y
   MD1Qf2A+EHuPI3y7mO0HE01iWrO2LsfiqvARsyhum3aI5+b3mdTKB3ZVR
   dxAqQBkfUWyzMqO3D4eHQV9sZwcduFnaMpHpmUoEYExCh+yn83KIvRS28
   A1yKmRrKKEY3fZmNOCwRt1BquWeP7AzBn0v+PwdQcBYqVHqJKtwaoQqBv
   jl0YCR9irgx+5jYgrpTR1QaeOEe3iNlnjS2ONRk//SJWPfCVrigDgJ6fX
   csOgao+rw0V31E+WkgKhNhk/5I0Q4LBAMi3SwQMBbjBnhkcyM23Ck3gqM
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336559371"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 22:04:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOgvE+Tns2HJr8/KvjX5UzPJslqoAPPSGvHhHbFPOKQCSp3o3pGEPpCjYpk3VbiV59aX4qc6wh8n/t1KJL+LCjYPHCAbgGdavkKvQcNAAtXE4Jl6h0VZGRMcCn8LlOFMzEhNrnwEkQY72PNFp3AyCy5OLazlAq1W5FjAhcneFKcQVHHnQGn5wXH5Q3myoThPsINpIjnu8Nn+tyIVShpdQQzcDEZk2UNaQ17hh4/DiImd+81js2owkQjS0i6V33LMFkhOBG4h2YGg4rM14uEgSD88wEm40YXss/oXJp4PCZ1MZGEos6exmt+i0+luHXoqVGYpk+DKTwPmNg5ry/SNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O17/xsk8C5zZWTfs1useH92ayZda7bcosEo47RH9tgg=;
 b=CfjqXHSv4QX4967i2Qa5UWFKtO/ecDe3+36cdCKI3RI9N2GSeYRfVJ7XFhk9SIlMQ8uDx92G9ChZvTHsg3vXP2Rct9NpcLuHsH4kHdjUijykofC7pMf5EYS0cdBKLe/uHTQH8ZNdXb+rZqPo/OVw7H52GSTe4HBgm0brfGl0ln952mSVRv7CmaYmwyOlz3FTua3TkOpi4ZO3KGrTm+W7lF9UkLW+WZ22ndX/TTndEVVZ6GcTlwJe5w+oNhwjyUrhU0+F1IT99nqMQNL4kGNSnQTmZVqtiOaNQ1z5fz4NuGQgy0xpHLjLUK+p4KbzNvL/FVLXvQtxEjzABf/bocK7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O17/xsk8C5zZWTfs1useH92ayZda7bcosEo47RH9tgg=;
 b=n1D2u0N5wFnfyBLa/NiaUk7vg620f34SwGSdu0jCJ7dPQdwZe76Bzw9D/+BGrJsPSdzzAGnDzIKN5vk3HYiXZIbL1EOn/fsbuKJeNfKq/z/eCOa7bh8JkiO+can1131XoJtR9Ug3f+NzJ1BPIxs/3BT1WNy31JcMBxnRO2IlOHY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6843.namprd04.prod.outlook.com (2603:10b6:5:245::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:04:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:04:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Thread-Topic: new scrub code vs zoned file systems
Thread-Index: AQHZk77F6OZSPckrzkClECKtofmqo690WysAgAACsQCAAAFPgIAAAYMAgAAJWYA=
Date:   Wed, 31 May 2023 14:04:05 +0000
Message-ID: <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
In-Reply-To: <20230531133038.GA30855@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6843:EE_
x-ms-office365-filtering-correlation-id: 35f4cb56-f024-4318-827d-08db61dfe55b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYXmzsq4nNKfB9MCHxuLTY7ddN2y6KnBoerOed2gG2cOUVXqo8S+Pv874wrmZAqX2Fx0mdXxvecG3T4oAV7uaeTEx1zJdxTrdfZdktAAoPAXeNpDvnNSCEO+hE7mHq/kjd+mrvF2aFpUTCaUkBWD/y/WxQNYBXcH9KqFSY0l7ABP21HL5tLeYHMk/p/I14I96qC/P+NXkesoUHMHw40Yh3PkHc8waSMfV1+rR2RvnrJhkePqC7N9NGqWXdG5vvfNQ9iaDcG4rvmYfhodF4a0CTiMonE5r82xSMxeeD257ipoTiXLNnfKFMEFHHZ0DFfR50jGFtcEPzOASGew7dmu2T2+i5wnpC2zbZKu/rnIOWTsYzKavalw/cJpNV/xwRYmRqXyVtmrs10HrZOMOa7/YXRZ6iJlxB1igk+KllXNxKWfhOUJbDxbhFwfkDVJGE4L5JWUyx6JFWzGgEUUec4yBPLUKYXxC71essEjaM8yUJLglGjW0TnsdO7F8g+3eIxhc8zQwM/vjeKG79qZcgIkUA7+hcddl9PFq1cZu6UnhIHdUel66rtyzrh+hU3bNcSIvlmpWmdu6/SZ0c8gjnu9Hcef0iyCgRhzBFeUkIUNXXeyd1NSZ4Oc+AxtEf0wtt10MYjpyMjMJl3d5Ix47ozkIqAijqn5So9uWfD2G0KHO1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(53546011)(6512007)(6506007)(6486002)(478600001)(54906003)(71200400001)(122000001)(66556008)(6916009)(91956017)(66946007)(82960400001)(66476007)(66446008)(4326008)(76116006)(316002)(64756008)(8676002)(8936002)(5660300002)(2906002)(31696002)(38070700005)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRhTWF6TlM5SDdvWEp0dFpJSDZ4dU5DVDdDYml6cGNkQjlxaEtacWpFdmdZ?=
 =?utf-8?B?QTVlcC8vVTU5VXJGYmVKdE1LU3pyS2JpdHRwTzgxcnM3NGJOR2FiVDNpTU9u?=
 =?utf-8?B?VWVJdzZtbXNUQzJ3SURLZWN1M3JYbUo1NWtERVRPaEp2WUR0NkFIN0lhN0N6?=
 =?utf-8?B?TTJJTHNhb0ttaE1PUUlmdllHcTV3N3U0a1RKRXllMURPdXRmMDl1OG83OTN2?=
 =?utf-8?B?NGp0L2s5UHlpM0dCNDFiSEJzdVRpa1AyaHdIcnhBUUxEQWN5Ri9QNTNCY3F3?=
 =?utf-8?B?RHlMSytteFJzVkQ0REJXK3BrUUQycFRjc2Y2bVpSWnpsVEFmdTVyOXUyL2RZ?=
 =?utf-8?B?cys5N2ZvMzNrQndZcHFWM09tVkNqd0d2bmJUKzZreVU4Mkw5ZC83Q1pzd2lY?=
 =?utf-8?B?WjZCWllEVXh3UlVoby8wdHdpWE9ENGJXZmo5VG1rMGZkczhHYnRrZm83VURN?=
 =?utf-8?B?TEFib0hpRjUyTEs3VmMyOUV5VlB5U3BOVzZSdGswamx1T1ZlMUpsRlhUbHk2?=
 =?utf-8?B?bHFwY3Z4MDJsZHlOT3g4QXgzRzdNc1FIL25ZbkNlRXdNcFIrcExTNWk0QWtB?=
 =?utf-8?B?VlNBZEg1RHRBMFVudzBtMzBGemV6RmcyMENidkhGSXUvbXZuWnBlMUR6clJ4?=
 =?utf-8?B?bGpkbXd1YTRhcDRMNi9kTGtpYkd0dXJIOGpROXVRbGN3cTc3ZTNGUzh4R2Ew?=
 =?utf-8?B?WHZEVllyTm1kMG5PUVVUSGVKQm82VHErT0FJVkhreXZRUmd2bjJsRVhKMTc3?=
 =?utf-8?B?S3hkQXIyeTZvUWNOU3ovcGQxTWMxR1FhT3lwOG9NcTNDYW9YeS9aVGlJOCty?=
 =?utf-8?B?NFk2cUZ6eUtuMTlpemxBdmVucUVLcndZZ0NzY0pNV0JqUzVjYjd5UG13QTV1?=
 =?utf-8?B?c2tJVVRzRStwdFliRDdRYVoyYW5KUU92UUVPRm8rQWlrRHJOUDlmbndReUxB?=
 =?utf-8?B?Z1FrNmR1WWduVkxWdS9BTjZOWkl4ZHpBTUx6MnhSNkdQWVZwZ3JOblZBM0Nn?=
 =?utf-8?B?SVZkeUhBbmloZVVCblhoYTJXUVFCa2FpZU1TT1BacG85bW9IYWovV3pGbFVV?=
 =?utf-8?B?b3JsK0pKTGxyeklTNWYra2ZGdStPb3VrQ25QRnkzYnovdW9wV0JEdld6MkZF?=
 =?utf-8?B?cXkyTTc2Y0pwajd4LzY3bjgzQmZCSWlPeExzeUtJZGsvMEVOVWRVNHp1N2dT?=
 =?utf-8?B?eVNnYklYR2ZjaHRSMndrZGMxUnhlcjlDanhIMFVQdGk4ZjV4QitvRGs2NTRn?=
 =?utf-8?B?NFZXdU1ITGllV1dqUDNjR2N2MUtMNVNtNnlmdUlWT3hhS2NJUEY4NElzTDEz?=
 =?utf-8?B?TWVBaFNCRUVXNEhpejdTS2YvVkJlR3NNejFub0lyME4vdVJsY2xhdklubk1E?=
 =?utf-8?B?dWo3L2ZNeENjR1RmUnF2bmUrM1NoSGxkaU95TTczeE1wQVlWWkE3T251Q3ZY?=
 =?utf-8?B?bjdGL29JTjQ4OWw2Z2orVENPSjNWWFJwTWlVUXV6My9TME1zZktJd2FSamtJ?=
 =?utf-8?B?emJoY3BYUi9kSXpER1VTRlgrcE4wWS9wUkZBMDJvR3pPOUIyWTlRenNzazlT?=
 =?utf-8?B?TkEySXNQZ3lMZkJSTlA3aHdzeUw5akFLbFVDdk83QXd0QTNJQ1hMSU1RVGI5?=
 =?utf-8?B?TEplQW02RkVpbGh1WTlUTlVoSVdLSm5xRWxUV2IxcVR2ZkVxZVFsMnN1UEV4?=
 =?utf-8?B?TVF3VVljUy9TRkZwUkxFLzhmL1FFYk9oS3ZZNkJ1YTk1YS9GQlFCRDMrcXpB?=
 =?utf-8?B?VkpZRUg3ZFZuYmx3UUlCQzN5VnhJaUFEVldhK2VnbUdwT2ZyN1VnYUZWL3U4?=
 =?utf-8?B?ODhTVFFwYXZ1TjFGcmRob05NRFJQeDdVVzNORGdJTi91WTVxTXNGR0l1TGY2?=
 =?utf-8?B?N0RhTU1QalJybkpVeWFwSEJEbDF1bHExRWtDb2gzTUlvN0NtcHJoUTlvNGpa?=
 =?utf-8?B?ZTAxMURDbjJyZzRicVV0cWtIUEE0QnhJcmh1R0VJV0ltSUhYY1IvU001cDdZ?=
 =?utf-8?B?L1lOQkFDRVJ0QklrL0J6NHlkTzNWejdFditUNzczUHd5Wm1SbjdGc3N0eFc2?=
 =?utf-8?B?ZkJ0U1VyZjJVTmY5aUdkdGRvZE9BZXhYeFN2MVQ4RmFwQ3haVEVqWWNDTW9I?=
 =?utf-8?B?ZzJRejRyZjYvNmxEZ3JuL25ReUpzV283TUtDZXNDRFVnYkhWMFkxWE1CSU5m?=
 =?utf-8?B?bHdhbnVUU0ttcGIwd2R6dzcvUXlkekVkUTNhL2JzRXdzei9hZU9tNmt5UUZP?=
 =?utf-8?Q?5eMVROVegmV5grWE2VhkP92qALRPVy8jGGoZMsL68M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE049454D5F57B459EEEF57DA2ADFEB9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wQKNNHJxOrY7qJYRpvwxq1j0rg20+QqovlRDaTYzts72Pa0zoQ7zcRGLNRMTQljOCoeeLPbb/7A9LsZJBpNNjrOxSGTnKgDPW2vyKS7dBHmmK7qnxHwG7Kx4HWvBkMVWft26kYM50XVhPEFzr+DR3pgV6Lz46+kUd7A6uXv40Hr0CK4SJkLjK8ql+49VhvD9KJR5lWNWoRh7LvJtoEvbhPdH3PY3EJ/tRTWhZ+cSJSek8ptOKv/iCMRXFf3wxOirE6h/yoQRS+/FIsvVfC4GCytGR0nOXC6RBdQHVhshBZ++amSq21fXSwBfBBedKEcqPdld+Esl1eaClBh7plw1w2ODYWFbwhQCHAYtZOv6dXUOmm1Kltp/BE7nTd02hgKyxdrt1uCOI9SOsU3HPDNkK3OGMXHnrWnaoPzZXu8JW8gMd2GzwvlTQKh20KApY0dsPLbodEaSlGMplMgnvKBL2Swd17rlyzFLV5G2/Cp3zC3dzZHF7d1HHSZW8/4GOJfNi5H8vTCLzqJ0kIoO8Hpfi+E/nKQBC2KqUD+RG/O0F/PJCreanZvRZrT+FRUmyd+pqdjHssho0US2Jr/fuMP9rOVMi1LxdTNW5HAai4wLLvGTnNAUFafsrl5tN2abb24uUkh6Ur6IGReOP9d03YNpTGW5st9xrQco+oha54e3ZL7voOgwUzfqwmeSVcPpgJ7pAt+U6Lwz5buoSCQjnaJOns//XPA2upzBsBEdQNgeelTklMsCb6DrDoeTqvQumiyFveYVGpfPfzOf0aeumfMT4DdseLFaNpdRH4A2vdV81HRN1+gbBTtDyaAdYwrMIYi+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f4cb56-f024-4318-827d-08db61dfe55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 14:04:05.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIXR6TPiqFXIVdmFWvDydQlQDczm3Cbf0ZzZJu8LGGX0vLMnNQqOcA3U8EnBIe5AVxFkpKQbCZQ7WYiUxFKHTRZmnuoJZimOlFHO/GXuyVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6843
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMzEuMDUuMjMgMTU6MzEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAzMSwgMjAyMyBhdCAwMToyNToxNFBNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBIbW0gYXQgbGVhc3QgZmx1c2hfc2NydWJfc3RyaXBlcygpIHNob3VsZCBub3QgZ28gaW50
byB0aGUgc2ltcGxlIHdyaXRlIA0KPj4gcGF0aCBhdCBhbGw6DQo+IA0KPiBFeGNlcHQgZm9yIHRo
ZSBkZXYtcmVwbGFjZSBjYXNlLCB3aGljaCBzZWVtcyB0byB0cmlnZ2VyIHRoaXMNCj4gd3JpdGUu
DQo+IA0KDQpIZWggYW5kIHRoaXMgaGFzIG5ldmVyIGFjdHVhbGx5IHdvcmtlZCBJTUhPLg0KDQpJ
IGRpZCBhIGNydWRlIGhhY2sgdG8gYmFuZGFpZCBzY3J1YjoNCmRpZmYgLS1naXQgYS9mcy9idHJm
cy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KaW5kZXggZDdkOGZhZjE5NzhhLi5iMjAxMTVi
ZDA2NzUgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9zY3J1Yi5jDQorKysgYi9mcy9idHJmcy9zY3J1
Yi5jDQpAQCAtMTcwOSw5ICsxNzA5LDIwIEBAIHN0YXRpYyBpbnQgZmx1c2hfc2NydWJfc3RyaXBl
cyhzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4KQ0KIA0KICAgICAgICAgICAgICAgICAgICAgICAgQVNT
RVJUKHN0cmlwZS0+ZGV2ID09IGZzX2luZm8tPmRldl9yZXBsYWNlLnNyY2Rldik7DQogDQotICAg
ICAgICAgICAgICAgICAgICAgICBiaXRtYXBfYW5kbm90KCZnb29kLCAmc3RyaXBlLT5leHRlbnRf
c2VjdG9yX2JpdG1hcCwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0
cmlwZS0+ZXJyb3JfYml0bWFwLCBzdHJpcGUtPm5yX3NlY3RvcnMpOw0KLSAgICAgICAgICAgICAg
ICAgICAgICAgc2NydWJfd3JpdGVfc2VjdG9ycyhzY3R4LCBzdHJpcGUsIGdvb2QsIHRydWUpOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGJ0cmZzX2lzX3pvbmVkKGZzX2luZm8pKSB7DQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghYml0bWFwX2VtcHR5KCZzdHJpcGUt
PmV4dGVudF9zZWN0b3JfYml0bWFwLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJpcGUtPm5yX3NlY3RvcnMpKSB7DQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYnRyZnNfcmVwYWlyX29uZV96b25lKGZzX2luZm8sDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNjdHgtPnN0cmlwZXNbMF0uYmctPnN0YXJ0KTsNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fQ0KKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYml0bWFwX2FuZG5vdCgmZ29vZCwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmc3RyaXBlLT5leHRlbnRfc2VjdG9yX2JpdG1hcCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3RyaXBlLT5lcnJv
cl9iaXRtYXAsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RyaXBlLT5ucl9zZWN0b3JzKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Ny
dWJfd3JpdGVfc2VjdG9ycyhzY3R4LCBzdHJpcGUsIGdvb2QsIHRydWUpOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KIA0KDQoNCkJ1dCB0
aGVuIGl0IGRvZXNuJ3Qgd29yayBhcyB3ZWxsIGJlY2F1c2U6DQoNCnN0YXRpYyBpbnQgcmVsb2Nh
dGluZ19yZXBhaXJfa3RocmVhZCh2b2lkICpkYXRhKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCglbLi4uXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBzYl9zdGFydF93
cml0ZShmc19pbmZvLT5zYik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICBpZiAoIWJ0cmZzX2V4Y2xvcF9zdGFydChmc19pbmZvLCBCVFJGU19FWENMT1BfQkFMQU5DRSkp
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICAgICAgIGJ0cmZzX2luZm8oZnNfaW5mbywgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgInpvbmVkOiBza2lw
IHJlbG9jYXRpbmcgYmxvY2sgZ3JvdXAgJWxsdSB0byByZXBhaXI6IEVCVVNZIiwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
dGFyZ2V0KTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAg
IHNiX2VuZF93cml0ZShmc19pbmZvLT5zYik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAg
ICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgDQpUaGF0IHdpbGwgYWx3YXlzIGZhaWwsIGJlY2F1c2UgaW4gdGhlIGNh
c2Ugb2YgZGV2LXJlcGxhY2Ugd2UgYWxyZWFkeSBoYXZlDQpCVFJGU19FWENMT1BfREVWX1JFUExB
Q0Ugc2V0Lg0KDQpJJ3ZlIGp1c3Qgc3BvdHRlZCBidHJmc19leGNsb3Bfc3RhcnRfdHJ5X2xvY2so
KSwgdGhhdCBjb3VsZCBzb2x2ZSBvdXIgcHJvYmxlbSANCmhlcmUuDQo=
