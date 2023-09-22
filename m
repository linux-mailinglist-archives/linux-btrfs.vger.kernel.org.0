Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808D27AB23C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjIVMgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVMgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:36:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1D8F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695386195; x=1726922195;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YpTTPoSa1plzvJcmv+t6zwnhUHX284Y3uc4530uTTMQ=;
  b=MNXFa/uosDPVBTitGiTQJh3eRDMrSy4KLVvylyIXM5hsCPri1RxY9O2/
   LalK3DcbmS4Qi1CwvHrxKtsCgoSRdgoXuq/SPbTGVmIJS8DC+fBpQbIrT
   E/IHpUsFm70FENQtMXvHCymt12EFhShkRi31SvBaEty81Koe6c7oQ3Sgh
   4tkIfRqzWedlUUTFKMrPsVMHcz58ghiiORjTAcBkOoPLBBgV9CN26GPsR
   wiG32E5fmtpZDH3nneBJ6HoV22BNhNZLZOcXAOqdS46xw6D+ogtR4Xqo9
   e8l1qAxbFUFDLfbVCIu8C0rxdlzF/Nr5FyJDvDBvj/KsHTch+WRqFSGX6
   g==;
X-CSE-ConnectionGUID: hRkSjtbvRTWOd0sZ/RM9zg==
X-CSE-MsgGUID: Tgrr4wZDTTS59MMmmzfPow==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="356724325"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0OVI+tUeM2wC3mNcEduZmRwzmHdtmxUO0R1Sr6KBkNSlc5Wi8ZaNRURVA1ihWH4vvh2zgvGInVOmGsL/7wO7hQpodsSpnchHbLQEEy5OGI143nfQxAwUaUDZOG3enn4EQ4UPKtrr2lG5LceZe7DF8DQ3ytDswmdYtIqb/3gVbEQEO9yOyfbVJLySyPYlk0fl33Vdbk5ZsDFWrDtD4YE1+dThzs4RbhJn7HagmOzy765o8d87HuBtA3JOwOnhq7lt8HpUhuv3UHRAkdW+kL3rqhPKZmj/Npkr10IM/4WCvzWrhqmGN+STRXy3GRZ7uJBFQ/ZJekH7i9WyQWso5qngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpTTPoSa1plzvJcmv+t6zwnhUHX284Y3uc4530uTTMQ=;
 b=USNIM9TbQUGk6RKwmogIoWzuN4BJBJcLIrdzTsy0iQAKZhwsGhezgdKMsG0wNfz4iCGuHvIBnJh0rsSJwkEZ1wTePJdN2bzbHncqFMImZdbiUW7+omUkp6FtalJq3mMhizja9Cw0LkwRZw6Tt5MFafxJHLVIVGZplP1njkY4KoDEsW1A/cQF6hqZwmfC+NAFyqWlfNMGFeJA2KLMtJYJX+mWHps/f0hU6THk8rUffSaSCQIzDO2QxNUzZs/SQ9IH/cALUBUaZpbjmG8ukZkLU1i6z5o1fsPAsEsVc25LOKGxoQeyyCEQfBJgQOP4CBg6etWWPwpqEuLLsWeYFilFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpTTPoSa1plzvJcmv+t6zwnhUHX284Y3uc4530uTTMQ=;
 b=DdYvUzOSJR7+JAN/KoLdiTOUVfV19iTkO2FJCMWlYzu7WzD18l+e3CGMROefx03aqSLSFYiBp5P6zaB2FTAzami5sVLkb28fY/CW/pFSi2Xb577P1hvhSnoDeL1npLwQPnAbF4tT382JNMPMqFNtBlDNFVxw/uytlUOoLahFqR0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7943.namprd04.prod.outlook.com (2603:10b6:8:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.12; Fri, 22 Sep 2023 12:36:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:36:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] btrfs: relocation: return bool from
 btrfs_should_ignore_reloc_root
Thread-Topic: [PATCH 6/8] btrfs: relocation: return bool from
 btrfs_should_ignore_reloc_root
Thread-Index: AQHZ7UXpY3txZTPsY0yCbXzA9vvgwbAmyEWA
Date:   Fri, 22 Sep 2023 12:36:31 +0000
Message-ID: <45290b63-f1e8-4588-8d26-c6bf21951348@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
In-Reply-To: <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7943:EE_
x-ms-office365-filtering-correlation-id: ec3d8f37-77f0-4005-e987-08dbbb688c90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2ZCG/eg+jLArGJtbtPrMWeW56wPbxdtx0Z/cMOSZQQgEFu5TAjLPt1ALdvhxmOZzznddpmcxbctmaR+UCBIW/4AGydZS1bT4tZqS0oTCu6N1fxpV89HHA1dWxMgKKutVPLcGNNPiCXuUjy8DMIgjwxSEr5Sxtc3tGA6K+l4Pqun7UAAxWf3III5POJTse/wsc2zr70YD+snJDYNBhbatc2wrDH7965y0zPCSMfkftkyA34wXU9PkHLv9OXJVJGlwzlvcW9dgrttRLPMxye0JMESeV7iK/3VmvT8unpdEpWhLzWbSerGl4RlOOnsqrVY/kBIlMd88jTR5Tn04sMkUHH2LvUIh7u2zMVyZiroEIbBmPuFkiBZc/xQO/apfiJeU6J4J9QrJ4NsA9cQ65BZLhmMN7u2y1m+bqDEcv/Of3K341c3Mr77LS9Y7MvkziiW1EKUSe7UCpuVUYMNLIRkzKu98+FEfz9wxM9mI4N5JYft78ndHUsJd9Dg1nGDr7Oj8d3VLsLOQ8HlJXDgdirwzASd/328rgcd9uqwNfYK/wRq6i5JR3hAqWvnxLDz5vXlD1+Fu8k0kFLkTCNe0o3Sa0LDgGPVy/zTPYHqDDjsvHFYCRx7ZT3JDYC/xR0gF8pHrocZvyDbCmmhIAicZca5/YMx4xY58718Tni0hmACDSwcZSKHT5YVU5/ataniaJRS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(6512007)(6506007)(8936002)(53546011)(8676002)(316002)(5660300002)(31686004)(478600001)(71200400001)(64756008)(2906002)(2616005)(6486002)(66446008)(66476007)(76116006)(66556008)(91956017)(110136005)(4744005)(66946007)(26005)(41300700001)(36756003)(122000001)(82960400001)(38070700005)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZzV1lSdnVLMlYvaHFMaDFqNnVydXpmOEdadDR0RzFrNjhteXRCSGIrN0Vx?=
 =?utf-8?B?Y1lsUWlLMUVoUEY4TGM2R2NzRFZDZlJWbWJSMjdrVndlNFRiZXBaUHVuc0Fr?=
 =?utf-8?B?bXFoeTVqY1JMak0yNk8wdDdaa1Z4RnJ3NU1hUmhTVllBVlRlWDA2Qlp2ZlFV?=
 =?utf-8?B?SHkzTkM1ZG10UHdqZTBPSEFTRVUxcUVSbkhlQ3cyaWVzTDdwS2FWK0N1OVNC?=
 =?utf-8?B?K0ZKN1hHS3Y3Wm91a2p3Ymd1R0taUFlEU0FYSG9YdVBlbTFuQ01iUmI1SVlj?=
 =?utf-8?B?L2dsOVNFTzNZT0lUcWpUWXdNKysxUGtER2tRSXB5aHZ4bjdGS2xJZW8xS3ZS?=
 =?utf-8?B?WmFOZ0pJVjEyQldzeWZHcWhFTzJYNG9VWmh4QXgwc1huSXM2cjl5Tzk1VkYr?=
 =?utf-8?B?OEQ4a1JGaXVZNWN3ZHp3TWpqaEhiYmIvcjBFbUcweTdyTFAyUW81ZjBBL0w0?=
 =?utf-8?B?blNvUGJUeXJXdDBjd3ZrNzVaaWhjSDJTeTNCM2pKdkUzdWdUbzdJZmJGZ05w?=
 =?utf-8?B?T1g1Vm1rdXh2WGY1aTErbXBSWGdPRWZSRVJydU0yMDVKMXdxMklaQ3VhK0JM?=
 =?utf-8?B?NXBxMm45eERMOEpvOGpaZTRDMHZTY1pNNEN2aTV1QXdONjFKTmxsNm5KMkVY?=
 =?utf-8?B?aFRQbVpmYUduTzgyRWgzcy9LWi9zNjBaU3N3K2duNjY3bXBiWjFnMldzd0hR?=
 =?utf-8?B?azJIZ0cwSEVGdjQzdUZ1U1AwY2NXSmh0OVRXNHNkbDhvWTNPYUU3RnJBNjlN?=
 =?utf-8?B?WFBRT3RVbWd3cWk0eHI0QmNiTUEvc3hMQ1YvRE9TRlRtVHNGRGJMZVl0ZWYr?=
 =?utf-8?B?eE8xZnFNYnMrOUhhMDcyWnFYaitvTG02MU5FdmMvcTNhZ2Y0QWgxdDc0WHBR?=
 =?utf-8?B?TkxEOTRnd25iT0JnRlB6aDNQcVpNQnRDeHkvTWZrL3c5b3NHVVpLTGsrR0hp?=
 =?utf-8?B?SmkxK1hNaGEvOEpublg3N2xibXJmSEc0OGsrMkxIZjlqVDkyWE8xemprek9U?=
 =?utf-8?B?UjhMdVJScG04aUJGSlpXRExhMW1GMlB1TkZhNnlwTGdTakJ5eUJPbjZuL2s4?=
 =?utf-8?B?QXhyQzVpbHlqRUZPTUdiU3ZUZG10a1l5WW1EdFNMVWNldUNmTStMZmtUaksx?=
 =?utf-8?B?akZabUhnQmJoQ3cyZU9VcWpNaWhJbVF3MTdYVGhubjZ4Mzk0RllEZjVrK2xV?=
 =?utf-8?B?N2lDZmJheG5hVlN0OVlFWEZQbS9PYmwwbE9SY1Roa3pnYThibDdMd0crTmxC?=
 =?utf-8?B?ZVU1eGFsTzhoc1FWQW9ka1o0dHk1ME5qYUhNR2xRZWsrZVc0SEM1TUZkaVJB?=
 =?utf-8?B?VFk3cUhDQmw2RTAwclFFV2NKWkdNSXF2bVo4ZFVGMllNWTZVaFAxL0l1WDFN?=
 =?utf-8?B?NHJpa296cTJnTHIzWDNRTDVIRXl2WlM0cnZscHhBU0tseHFJN3QvUmIwKzFR?=
 =?utf-8?B?Umw1Q3B4emdQTXMzcmJseVFXdTkwcnJhMk9YNU95TVpuRW9aalM2QmVYbFEz?=
 =?utf-8?B?Qm9HT1ZqU0Z0VklMbzNoOUxNY1ZseVhoOSt6OU0yYzd1Slk2Q1BWQ0Q2VnJH?=
 =?utf-8?B?dkZzeWtJSk5lUG81OEdhTUNtWndHRWVYSXZ0Vm9NRitCNVpHL096Nzk2NDEr?=
 =?utf-8?B?YlArUVIzY3JURVlBb25BYk5lU0Q4UEZSazlrSkNiN2RRRE5wSkJpRFRKOFli?=
 =?utf-8?B?R0RsWFJqemtGZjd0NllxKzlLcUpXZ3VmSHd4cFFacklqdHM0dU9zRmRZRmQ5?=
 =?utf-8?B?WHhjT0MzZGZ0L0R3aFJEZ1ljOENScWdFTWQxZTRva2JzTUp3eStYNGtsUlV1?=
 =?utf-8?B?aUdncDFlK09EaXZzb2NxMGFTSStMSWVqK1VkUDI4UHZYaXZQb2RMc0JxR1gr?=
 =?utf-8?B?UE8vY25ScERWVFdSdkwyMlNEUzQxYWZheWdxVDlPTEt1L2hGSUMvYWVSb0pj?=
 =?utf-8?B?Mk1GWXcyYTQyZno3QjBITFJ4U0Ftb1dHVTJ1N1krbWVSd1F6RXNNMVlHRXpm?=
 =?utf-8?B?RXBrN3MwWGJIMVFzMGVnaStzdTVVRnhSYTZRQ09XOXoxMzBQR3VRaytjT1la?=
 =?utf-8?B?TDU0WGRTNFNoek5NajZTSVByNzhEeWxRM3JTSjBUMFRCOU83ZzZzVUN0dmkw?=
 =?utf-8?B?cGsxNjBXWTlNdSs2QVpBdHBWUER5bVZJVjk0am40SXd3d2YxRENJWXA5ZUl2?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD4E62F587E1BC43B96D5D45B2E88B5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cGbN/TRs87XYoveo3vZxeIcptnV0t7PTivXa3IvGiQ3nJAeZ6v1JbAFf1VbCbEyXfY0HpUZ4QM15ksl5TSFw6940fq+Kkj1ErgNjiFC6fQ6Hv0SYBmFSEu9gbKkC+D0S9rmSYS6nDkJoN7hkTnGSc9dB5Ww9NaJUtTXn+nqeoanTJB82/kKrBcv+OD4kRW7C70SEsB6bEPKD/I39bH/RLTneFL5obUy0AVmhzECIz9xlAthqLjxBtIKVYEVHBrZ5f90GbtZIPFFP/UW2K0KXNlJJZOJq3POq4sUlW1MucoJFUHojyZUmMJ7sCPf/tpc5Rw5JPDSDka0WwI+VBTvRWdhAq4qv8R2QAe9AmyNUrvZJI9dqRk6JuIO5SuohzD/RPLtw/sNDfyGxsX2jZdEGtbI85Kc4UaZzygsO9kd/jxDmp1OvWG6mSTYuMJZzGTMCK+6+WA9xbUj/kYvTg9N/zSagFbgAlNw7rU6F+AFrCjiN++BnnfVRWtn4mMnkWZD9AQwmOkSJcYpHXO2GwLd+YXhPrE7TVb6s1Q+jTDyFCkyiG2DUxtPmWqoOf7fVGpRQRbkw8dOEQDok6KQd7OMDcq0I+o8NsKWP1jXIpaiiwCkwNaxpsINzSHwH9TnR/eXGXrEvTXl8vJjoVACa2k1psstFEFi5nzgt60UA26g+VlDXQ9SjvG9vv0gv7n/x8yp4WJl0eGl3SbLky2qUlusdQdNmYM04JJge25yLpHZct+ClUe38K38N2/DiTSLNpUWPX7gyVHdU+YzujyXLvYkmOckZm+ucVBkqd4tuvKiVgIjHALn46prtKCvqwM3tS3oT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3d8f37-77f0-4005-e987-08dbbb688c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:36:31.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCvq0vgfTCNUYdK3DSCKl59OD2rfP0IZcDcGISW0evwhypEw/2u47yYwr/Zsdo4b29CqiZBfzXeVFrRUJmm+PpuODvYM4YzNc7l+On7kkQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjIuMDkuMjMgMTM6MTQsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gYnRyZnNfc2hvdWxkX2ln
bm9yZV9yZWxvY19yb290KCkgaXMgYSBwcmVkaWNhdGUgc28gaXQgc2hvdWxkIHJldHVybg0KPiBi
b29sLg0KDQpCdHcgYm90aCBjYWxsc2l0ZXMgYWxzbyBjaGVjayBmb3IgYnRyZnNfYmFja3JlZl9j
YWNoZTo6aXNfcmVsb2MsIHNvIA0KbWF5YmUgdGhhdCBjaGVjayBjYW4gYmUgbWVyZ2VkIGludG8g
YnRyZnNfc2hvdWxkX2lnbm9yZV9yZWxvY19yb290KCkgYXMgDQp3ZWxsPw0KDQpBbnl3YXlzLA0K
UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCg==
