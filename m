Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26836B292A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjCIPvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCIPvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:51:48 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757DF2C24
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678377107; x=1709913107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=MeawAKGaj07u0BaJNe0UGHn9Rk/WQKzrtY/AtP+jnATiaKz1zJlXnum6
   YDukwtUxLcqK5OlGRpD7v/ZxwR9zrHuIIt6Y39V5OQ3Ag9KKAW265Oh9+
   cUrBOmQk4AUmH51y4j/th0/2LHITBWAoO7PbqaSq9tKUftOcM8BmQUGZI
   3dhgqbBO4sRR5SHgc09nBkT8I/sovKHLeGgThCdP36IPc+XOdVIw8pE0V
   11uwZssk/vkXIsiqujWXkLgkenQWCOPge9d4FSx3h3fmGtXOykWVFH2nM
   KXQLeYokAtwpxTHzUiu5O06hyhZj2p5HeA2vDYrRFLOt1nS1Z3kWqeaWF
   g==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="329596581"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 23:51:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjaRhYfdknp1g/2iWFfcKiq8xetj/XlwMVDXXEcwcvrP+FACQYFM0q9l8dRvnE4Gifw1CSFyMgP6+M/Ab1sPVKOKsuFRadAQNDjPIkEZ+7jso1c1j13Qzjd+PbhINxtptP1lgRfuRMZHEQIP//hlwBWBQx5IeqtVj67Xxyj8ti4G/s4lMJrTVIaSb0igJG+dvMGQD/AuwGBsl44C16iwfp4cLdjJBStzAQu7NZ1JWezREauUdZZVpUvz8biQBTjDzl2KhljIrf7bemxl6ulvJCiHuj02AEt5DSzTe92yt3B8dxm3KCWNpohfFUh1tj5utEhMnK4b1DBiSoiy+SJtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Txu9NLMv8Qj6J28ZpkLtNta16iWxMJxSDcOFEgN/9BhwEm13NXiqDclJXANTO7H42d3WQdSV+gghRBm6+gYU3HnuFMkoMZLreOxgQ0F9LZyt7iBe7eSiodaydoBfRxjy7G7q16mGOeYr9Oke7Dfr/bQQQ/29uJEkaumKzCQ3JlJaHFUyqnmZIqfm++SpbdF483lLJrBKf0rh2irlKrTBQph38N83gUkHihsyIoGl3D2rxUKL/4MYaFLkcmcu063LlxsjS+TtubR1COz0XzGmWtezKxv+4ui60ydw55S2Z2RSqy/5fer8E6cUbWAdZ4YPDsSRvATJDg4Z2Onulru2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jELwE6C57ki/ChtlArldRN8WNRS7dv0fQW+H0MUoajl2DiBOXOwI/w07kJn2SlwX2/bz8TQJkfQZLw/230TJOUxpdwOzJu6Y5FB3QpITS3JpQcjw2RT+vjDlP5WZctkjeVN/ICIeC71r6KFDEHfNWz0g8tmDyr8z1m243jPA8cc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6927.namprd04.prod.outlook.com (2603:10b6:208:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:51:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:51:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/20] btrfs: simplify btree block checksumming
Thread-Topic: [PATCH 14/20] btrfs: simplify btree block checksumming
Thread-Index: AQHZUmatYI+lpvi7mk6ZjDjoWr0P/67ymUeA
Date:   Thu, 9 Mar 2023 15:51:41 +0000
Message-ID: <d070d22b-9280-16e1-0c58-eac46164d82a@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-15-hch@lst.de>
In-Reply-To: <20230309090526.332550-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6927:EE_
x-ms-office365-filtering-correlation-id: 4ee2dc7f-4b3d-42aa-d43b-08db20b62d31
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdKMWvG8vME0gNp0g+w2Mhq+rXQsXbSd3RMgauyoESxGfX0z5kao8fNkYs3+GwRoyshb23DMCBoONuqzcDgXjDcYZFuDkxQHR/JE6ERm942w1P9fibLDKQdO1S5nnkBYrYCMmxSNIzdiZ2k6cAoXb+QaSNE63VZfm5pzBegMaji1kA/KhWLe5EaCNaU6SdCcQcPf3cJYbf/EsE8amDpxzspMDWeBIYvVOVDP264IaADGDOX830/6ARHpMOCEaEZa5DPA8sZY8YyU3rkjsfeJWkOctmQE4jGya1TsZk6DKcjqlM6VajfEZcbuEUuS71/OR8UqZKEtC+D9bEgDePHOyB8MF7uljU3FvP0yuw9GnmAwSSYROMgWS0AO7wbth92yswlch5VLqG40XKWIH5j1KpS1LI94qmQ0WHOOgvLQ1g8wxWjZHzaiu+EQOJZ3LssJ3Y9ZoGnqkFUYabFcs06o/98NpjBpBzhbBI1i7LR/MsmuHQBuhUwwWnJtl+VpJwDt/Q5W4Grahns7tiRHCoFhsKv6IQv5fW4zCUZIptxjO1UIXTxicsm8fy8np/+TEINEoZZEtRnBo4nlQn8pckJxXwxXEqGVTlzXNIomYCAMXm2/ZkkxrxqsnBmePu4+LyAf3Qn+Fxq547p+ZhJtUqMuaX3uUaCFcnQdU5VvsOsEhD6Akox271OU7VRre15t5k4z1IUHXC/DVOx+eyr0YTc04dz0DahIS+/TIrmvjLLZcATSzcYPnTgcBiOWYOzc45cLqvKWPkwFDSmjitOfj0GlFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199018)(36756003)(186003)(6486002)(71200400001)(82960400001)(41300700001)(2616005)(4270600006)(6512007)(6506007)(91956017)(66946007)(76116006)(66556008)(64756008)(4326008)(8676002)(2906002)(66476007)(66446008)(8936002)(5660300002)(19618925003)(558084003)(38070700005)(122000001)(86362001)(316002)(38100700002)(110136005)(31696002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bThSZlhLbmdJS1BiR0xBa2pKQnJpZUpFMkxQVFlaQkdpSkk1a2Z1dFMwYnFt?=
 =?utf-8?B?MDVQN2hOdUdqVmVTVjRqZ0I5UFlkeUhTa3FIaFJWSlZReDZMYUFCcVVmYXVt?=
 =?utf-8?B?ZUM2aCtVSmxvOUtBb2RzRHRqL3Q2U01EL1pXRTIyaHZNOCszRGYvY214SEFH?=
 =?utf-8?B?ejRYaUpnUTZ6aWc0RUxSUjl3d1VwRGVUL3BPWm5ZZ2FyN25nLytxQnpiRUov?=
 =?utf-8?B?K2lBeWp6SEpqQngvNGpTV0MwOHF4TlpwTkYzeEI1dTdMRkNia3k5bEllR0pZ?=
 =?utf-8?B?V05McEhSQUxHUmF3NXhmaG4wcTFnRTNGQURpcU1WZWVGc0NzY1pFSnlSZDg1?=
 =?utf-8?B?UWt1SDl1SUkvOGJiYUhqM3FEU1Y4M0NwQXlTRHplWU1TdmduYjc0TW1LWUJF?=
 =?utf-8?B?Zi9aNVVXcnNaanQwR3QxQitYMlRrRTduc29mRFp2R0Fpays1VXBxT1N0YjVT?=
 =?utf-8?B?Y1NhZk5Pd3FlUmFjNlFsZ0dYelZ3UzI3dmxhOWpDNmpNMmxsQkxTZHM0VEFs?=
 =?utf-8?B?MjU5QjZaMDBPS0tHODZ3bHU5cG1xRVQzeDFVZGNNR1RwQlM2K0psSjFvQzcy?=
 =?utf-8?B?TjVoQWhnbjhDQ01mTWczN3NueTZMOW5JeFBYZGt2Rmo5QmdwV1BSM0l3WTUx?=
 =?utf-8?B?WWhGOG5adjl4akxtR25yS3FIK2lYYmgySitlaGFvQkxzQmxYc2Nwb3IxL3NS?=
 =?utf-8?B?RDVrRnVBbGtKZE1ieDVSNmlrdnl4UXZja1hKLzBKZnhrcDF2TFcvUUdwdWdr?=
 =?utf-8?B?WllNZWllZkRGSTA0Z3ptMTJnNndrVTU3N0F5ekFXYjVWeGtmVmFyRkg4cHF5?=
 =?utf-8?B?Rithcm1USVNQdEcvRU82QmpNd21HUk9rZ1lrVnBhVlpjaFhVY2xSVnV6NHVO?=
 =?utf-8?B?NkZyOHp1d3VPbTd1Z2s2bE4yU2d1TGs2cEtJKzhFL1RKNVhpZGMrbjUrdS9V?=
 =?utf-8?B?ckxaNk1MTkhmQ2pBM2FmUlkzSEN3bnBsM1BHUng5cDY4STNidXpwZzFmOGM1?=
 =?utf-8?B?NmxBSWxORnZZZmN4aGJlWVVaSloyVDJoNTUrRUJDWGxpYzBiTnNPMi9HUm12?=
 =?utf-8?B?MStKbzRsQjhTVVdBck4rUndJOS9vN3JORHRWQWl5VDNwMUVYYy9JakpYQlpp?=
 =?utf-8?B?bzE5ck9SeVRwTzAySFRSa1E3eFpJWEJNa3pseGpsYllLQkw5WkFlQ2VJSGFu?=
 =?utf-8?B?dUJJekhWUVFKTGt0QUFQL3htNlJOM3UwV2RiZjJSb1k4cVhNd2xTd2FCQ2N2?=
 =?utf-8?B?bEJJek0zRWx3U3RveVZNRFJheDFDenROWmt2YncrekJaSEhYN1B6MkdYS1Z5?=
 =?utf-8?B?Mk03eHJoNGZROFYyeUhzcm14VkcxNC9oVzlHZjlLNDdMNGU3b3U1YU1Ya0t4?=
 =?utf-8?B?dm96NjZjVERkSTdCcEFiUGRTNUFjOXUzSnRsMGxveEZUV25VN0R1aDM5Mlla?=
 =?utf-8?B?YkdFcUtoeSsxSDViVnlWaFVTdjdFMk5VMkY3VW8xb3Rkak96Tll5WDZ0RmJr?=
 =?utf-8?B?c0tnaVZ6YmpiLzVzY1YrVW43dUtLZWdmWkpiWExvNlpaaTVYbGVoKy9UUm01?=
 =?utf-8?B?bklNQVZTTEZOTFc4WktXVVlmQ0xDQk9HZ0xCZUFTakxyVDVQS0JUbjN3eHFi?=
 =?utf-8?B?ektDTU5LTnlwT2FYUWdyV0NSODZZRE9LRDFNekFST0EyUExyTnNoTjBuYVpr?=
 =?utf-8?B?MFVCM2NLSHRtWHB0NGRnTFlBOEJUM0lNQnlDK2xQMkxNRnZtQzdMWEMvbXJT?=
 =?utf-8?B?YndIeUlmdmNMSG41WERWc3JvUVdDREZ6Wjl3Q1FwNmFHaVBtMFlsb1V0N2U1?=
 =?utf-8?B?NmdGSVFKQ2tKNVRsdDdHOWZCSXZUREJaZ3hoQjU1NXBEWGtYMnA4eW92dklO?=
 =?utf-8?B?QWljNm5xRDRzZUpBaEt3ZjhyNDltbG5rdTY5c1UyeGM1NlFJYUNtK2dPbWF5?=
 =?utf-8?B?Nmk4b3YwSkxyTCtzcVhXSS82RDRRQUU5Y3B5d254dnBFbmhtTjJnZXZGRmx2?=
 =?utf-8?B?N2tIN21mc3g1V2J0Y004aUg5WEhIdlNwZGJPR05DN1FlU2JpMkQ4Q3doKzdj?=
 =?utf-8?B?b0lNNVJ3UzJrS2owcVFoV0F1cGtIR3FWVjE1cWtBK0FzdHRMUUR2cTZybkFm?=
 =?utf-8?B?ZVFJbGQwTWVhNWU0YTNlMG5qRzlKNDNxTFpvbEhxSmNSdGlybUx4MXRuenJF?=
 =?utf-8?B?Q2hYNEJnWEFySDJtTXpqSmZaRm02cXJ2RForb0pWamFyeXJ5QVJYUFVlWmNV?=
 =?utf-8?Q?Sa2mdIViWffwh4C0z197H35twKx5icYWTgzi2/Akgk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D540B77B61054785F6FF0B37041D47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lu8bCvgXlG9o11rCR9pYuvsoLfIvziVHWbHmXryxNrDIIUHac7cuhc5v6NeB60ul7ly7ClkOlYk/Z89+s2jkSc/xCScxL4QUfLBSXwXLozl54pWbYMapRNrSi0YU6Ao+JKQCkGLlFe0qkNV9259HPQUBPP6FsUsE4mC1zw9mieDhgw/VCnTwqryMNDTmWDR4d7iLsDjQ0LblrumvQRVL7hOlvStTskwkbUTRVo3w2fhOk9yqWW8a+XGuk6NTWjVkWs3tbp0FkhKHOiqxwsAsRQq8zfI/eQhNYcThxxSSkssgF/r0f4nv/oRZpPMttt379VNJjLKS874Pzh4X2vQR2sFUfRzLNCt+lmhWjJH+z+OIHy5d9hZD+f/t9tk9LtA1rV/B3BuPECL0QEroIpN4+HVS+DFkJSpJ0pxacS93aG+BA9TqhD4M/6p7+e/FL09j5ZJ9V8FbRxL448Y5ZS19V86SVb7lFhkhB211kvX6Rd0cPC5WoBizbFOMgj5nN7ywuxGb1nr6prpo9W0IfgylHhFj9Nhr1Zp22TrFJs8GfBW836x7EBs7GKRb0dgk9Sso/YyGCu/5BLhg54bjANpa/BuoHgcAUoXbPHpsSYonDgrT0bJSnjXMlinYXrFbTLddiEGc8ymMI0hX7rSKBvMYjkx3awcH2JfXam8kPyO1X2qTkvjZ9xoHBnIGTUmhBQ/GukKqVA8tlaKwAPY3XQyhlz1UpupWMavHFCo8bUSC+TWMhXgZV+GAeO2Rh8kx4p9+2+5sUntCp8JyU0qZJUDM273GnAUOCaYVm5emVqs7Db9SUvTx1/S94xWf8nitO+6blKNcopKXD/5O/qLP1p9Ay5rJdNqgcShsa76a3aCwZMD0bQzC7AJa/YZF3NonSiGP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee2dc7f-4b3d-42aa-d43b-08db20b62d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 15:51:41.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdmCWnd5GW4d10ysB1v8mS2/jz94m0Ne8BLRwg1WzCtDEUGBStyaPhu0S95WSaKoDVbLzjm3UWFB8SwcsqiJjTFUnuCjZgIPgbIWgrDdnGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6927
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
