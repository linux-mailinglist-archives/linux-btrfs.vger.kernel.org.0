Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94DD5F9A91
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiJJICK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 04:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJJICA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 04:02:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7153A4E
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665388918; x=1696924918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K2IZYQ4nZ8ITrTBuXZ57J3yhBhcSHJYrpok+w7prVOQ=;
  b=Y91CL3EbNGT/14Fi5sxOfC16x7YmmXGpbenRM8MKTL/MspiLpw5ipwzQ
   TXX2GsN2/tmmZRBCZKfP3+c55+1m3m+naX0Au4ijPpQNBjkoZIfiwe6FW
   k3n35va3e/LWbUNc8uN1vsQp5AHkHQVvxJ02fSjOCNSLRGEfUL15qgVzO
   cZ1SrBeWrA2ZokLX92sx0JZwb+4Ztyehn/YvtntkZjztQSoKaNlHErNWg
   iFeta3fHcVGIgdIjGdV1XWCs1wWZEaspJU8QkYr4SzCVVQIBHfA8sflyd
   jy9TnIkBKfuR3kZegYTFOFn5ZzwtBltjFQZ1pcr2549wirjZ0G2ZTBYCV
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661788800"; 
   d="scan'208";a="317681515"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2022 16:01:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiEMX37pF8yuFQFshjtlXqHaa0TrqY3LJHS6BoDl2rvjfEAQODi3Zwh8Xv4WZzfs6Q3Ba7Jd2R5mzyiKp3dYTTdnHe6MBz/v3tYmtrj+ttfz9ctsyMHmg27TXfk27lQ30nhJqJ/B5o+37EVWtaJLnV8xzVLnt7bPtsM41tJXdp0gOVV7ALqPG1z5rRiGaLG6RgnzAPQvH4VLHeCTA4XTqQjjdIp872FeVayYNB7c4Wh+Asnz53PLQLZwq20CMfA1KaiKhXiRk+SYhRmcASgO8raitCqJJTWfZRx8QtMDyWoFhm8arLb3X1uumxh0s1Zl53jPYRr/sCT3AGnCPSnYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2IZYQ4nZ8ITrTBuXZ57J3yhBhcSHJYrpok+w7prVOQ=;
 b=iM6SIcoopdfpIkC8q6igMZuKXDA5CyWWD/TdhU33cJ0lPIJRUlmAgq8jmnkSl7fY6erOJThG1BaV0Zx3PH5Eh2NAoS2RNuAectX1FlK8yCKW7nYhKsNstGK0P4xsDVMH9c2nF9RYk0C+itkfD8pJyFEGedGazUXFsUJ/zV3CjIr+h21mzrGfEZSe7G1hl+2wCBWMFQoKBVMwxyM1Lx2llNrwDzGNT1oxXj1ep2D8DbDLFoS6mHBNgrNyjPTaeHpkAULUCy9nwh7W65EersCXwfVuEVtxZCZ+ti6A1YbQ9k7GEN20QyCJ7dNkmsn9rVeK+ar1CPjbJdw5wZIjOd0DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2IZYQ4nZ8ITrTBuXZ57J3yhBhcSHJYrpok+w7prVOQ=;
 b=tVUdMimfc7f2In9r3Sp92aMPVWYqyT98c9dGFvuFcrhPXZoHlKxLycPYWtniAWNu7rdU8oyEgPHz1ranCs16tlQZJ+3PIQg+qM9nwJMLxQqbOltk+2Ovj6wtdSiNt/tinbuLmcqNF1ZXt7ialJDPJcMVUjYTXd0pzg7oHPkZxbQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6303.namprd04.prod.outlook.com (2603:10b6:208:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 08:01:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 08:01:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: code placement for bio / storage layer code
Thread-Topic: code placement for bio / storage layer code
Thread-Index: AQHYwpnESFyXKKAErEWmT6wq2L9F564Hd+sA
Date:   Mon, 10 Oct 2022 08:01:54 +0000
Message-ID: <088936a5-1166-ca11-98d1-e09dbc0e0d94@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220907091056.GA32007@lst.de>
In-Reply-To: <20220907091056.GA32007@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6303:EE_
x-ms-office365-filtering-correlation-id: 5ec89523-7871-4f6f-0b0c-08daaa95b27f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTG53xLY3yMQTX1Q1lZCPasKPQDQypODBC4kyTJwHXoTdPXkwBgCojddRX0f6ZE4p/dlEA+KPL4yvw8PDJsia49PsOS/xovIa0BtyWPpYMaVtvyj2PyFONEhOuaXm6Xe9l3E1P3PFjGn90GuyBDprZcXIZwMFr3wJij4Ev4MfVQM2mko8zHOAfBgea/tF5PNnHCoqxMmIQvYMpkXJehxnvV+PtJPkjNILBHYmSrTmJpud2Xoz6zY2rTse342kUbLVgFfUOfadD7K6oHpmsQKqQH5w6egAtJmfDOZoEL40/20DDZscgi1BzjI2yZLraTyaCc0tPNI9yWTMi8dXW9nxszHu2CPzdd3WgWAF88E3HwbQ7BUDU1098X8EqWyvVGRnnMSZs+bYltPyc7iFdhKaUtfdmvX9vK71HiY9zajLcVZT9R1uOBHvuzzS+fv0sVsebpi2xCFkBryBCwxomdYQCDhaKbNAHzCq7YRiRY95drE00dX2XoSF8QdL2nS47kSPqoly6Xc7LwuWSR2WtIU4lAhqfRc1ZyY8p/A7kTUWX6pzhqf+fTYUnjeE6VSxtE9m77ehRvEdU7GXcCtwdE3zErasITy58pn6tzOxY9aLWXObJGjtLi2grSx0sBBMotftiaSN30eWAH7N5byw26292UbWju3I6sDINEGuCgGlurAlxVxYOGPqWAqhPZiqwKUhNUhgx7D8cR4GfI77o3hmeL9fFMCAIZZ12B7sVEvJqTtKLP3EcADS/oEY+UVrjvtFIMcqccUXlhcc22CWMTNfDPaxYqng+TtXuLpQUR7vaeAaCxiIznMNTnnx+4sxam8o98mRZBDkB1WxwgErovUqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(66446008)(2906002)(122000001)(31696002)(38100700002)(66946007)(82960400001)(76116006)(4326008)(8676002)(316002)(66556008)(110136005)(54906003)(64756008)(66476007)(4744005)(186003)(41300700001)(5660300002)(31686004)(2616005)(6506007)(38070700005)(6512007)(71200400001)(8936002)(478600001)(6486002)(53546011)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnlUbUZlTVpkcWpFQkhYK08wTGYrY1dVbVlhRlVTMlhrQjZLVk0zeFVBYStl?=
 =?utf-8?B?TjhwZ3lZWDhndjJyc3VqZHQ1SDVnMERSamYyQ0RldXg0Zm5yTlZnbjgxTFRh?=
 =?utf-8?B?WFBrcERkNE1UNmRoK3JBaXNxTjZmVFhrM0ZwZ3hXNWNsT3NRTExKQlZwZmxZ?=
 =?utf-8?B?OVlWMCt3aUZWdFN0T1htMnUyY0MvTFNzQ2RYbHJneXhZQnNaWlpWVFZSUE0r?=
 =?utf-8?B?RCtEQ01SSGhQMXMrOGpBdGJ5ZlRMa1kyc0Z0K3pzeGZZenhvQzZuZkZSazh2?=
 =?utf-8?B?Wi93LzVZVDVVZHVSUVUybTVPa3FsaEdCbjNmYzBtTlI1WDM2NEhlenFvbENE?=
 =?utf-8?B?Z0Z5cUFVbW1YVmRzMTBwUDlaMHFkZ0piUThpUHVscVJndHpXaGduOHlRM2pR?=
 =?utf-8?B?MWNYbFNFRlJhWVA0d1Z4RlUxVThWeTB2c2Jzc0tLSnRSWlJHSzdHaWdTcTNI?=
 =?utf-8?B?RVRhOHF0dnFRNXFvTlEwWlFqdTJqbStFYlJhZUI0c0M5MTFYUFo0MkFGVXpk?=
 =?utf-8?B?MkRkdGNKc2FZZHgyWVRha3hrZC9ZNTNRL2VKS1A2MGwxR0ppMnRSZW93VWZH?=
 =?utf-8?B?TmZ1NCtXd0Nqb1lQdElUMm83L00wcmF0MXNpaWRCcWdMTjNoclZmNFpZTThq?=
 =?utf-8?B?YlYrMTlsajI3TFBVTWJhYnp4RDZiY2VJSXhzbHIzN0pCMnRaVFZVNlNyb0Iz?=
 =?utf-8?B?S0YyVXJIVzBUQU9RdnBlWDdPYlJHZ2RlSkhFOGlJb1dDV3FRSzh1cWp3bWpu?=
 =?utf-8?B?SlFTeDZOclFlQnlocmtRYVZqR0lMOW9Qei9WOU8rQkJoRFJlZkZJTFhvMm9w?=
 =?utf-8?B?d0o1WmtxRDdhOHozdmNFcUNsUzFlZStGYzNBRTQwR28vcjZRT3VkbThOb1VQ?=
 =?utf-8?B?QnhJYlZ1WjhFcWNrQ1c1RDVxTS8zdWJtY05pMTJmbmJwbmdJdWw2c1QrN0Ur?=
 =?utf-8?B?MkR4YWtvVFhXSWd2Sy9QNmk1c0dCYXNEblBGdng3OTg3R25YOThTUlhDazM3?=
 =?utf-8?B?YVRTQUZlR1dlcHZDV3FtUlIyU3Y0azJWbGdOcEVmNER2TCt1aTJCSnVaMXdm?=
 =?utf-8?B?VUw4K0JxR29lMzcxT0Zqc2RGTWlycWQvck5ocFJsUlF2MGtCM241R2RwVDBU?=
 =?utf-8?B?MTk0QlJmdjJpWmY0WE5PUGo1KzRkNEdNaDFCZGhqSHU0b2N5eUk4bVRiZHcr?=
 =?utf-8?B?bVdLNVk5VG5nQlhiRUR2V0ozQ3FUUzFMSVNPWkc0eVpkaGRSNHJ0N25NeWVv?=
 =?utf-8?B?V3l4cXFqaUVNWTdZYkdnQkFhSkVaMVMvTDJvNE85NVNYbUpMRk40bDlIRGNx?=
 =?utf-8?B?VGlRQmtweURQbnZrRExkaW9RRFovWEJNcGN3akd5YjNiTUVFMzVnSFBReTlO?=
 =?utf-8?B?VG1QYkRvOWZ1cW50cXJLNmtuR2V6NVEza0MyTHJZN0dRQlBWKy9raTk2NkJh?=
 =?utf-8?B?UkNmdkkzS2Z6eFJRZWJGcHU1NDdnWGxoQS9NcGlFamdja2pRYkQ5MmRiS2U1?=
 =?utf-8?B?VXFmS2xNeTNuaTVrZi9Qd2FnNGtQTG92d0tLa1J4QkoxdHh2VkIveUI5REM2?=
 =?utf-8?B?aEVvZTVialBGTTY5Lzh1SndQYVd5T0NMcis3VTc3ZzhHN0dwY1R4bWUxMVhP?=
 =?utf-8?B?ZGUrU0duR3BUbXhaZXNvYk9EQ284VzBFc3psMS9nb1ZSWkVhZWNnK1VGWmtT?=
 =?utf-8?B?WGhhZ0dteVQydjhtT3FHejI3QStSanAwcjIzb1NqSjJCZzhOQXpJUitNeDBG?=
 =?utf-8?B?aDAxN1dLdEd4ZTNrSU45UHJucVZtb05keHFUQ2EyNUpLTU95MWt6dnlrTk5x?=
 =?utf-8?B?VTZXZm1wT0x1R2gvWlprcmlvdlRvOHRucklqODhkRmxSdmd3ZkExQXdNQm9v?=
 =?utf-8?B?NTZxQ0oxRy9BZDhuZHVkZjlzVktQMDc0aXZlWkFOUCs3anBwR2c1b0I0UlpU?=
 =?utf-8?B?MWo4L2V4SGhkMWtnWjk3blZEUUpqSTdZc3E1WVE5UEV3VDBiWlpxLzNLRXND?=
 =?utf-8?B?WkxnUHg2NUtBRW9hdGRLL0ZoKzNIbGp3YWhjc3lvQ1BzMXJsY0ZPcVBGNnRL?=
 =?utf-8?B?NmdHTEErTjVWQUluSHFRRDBhZjRXTGhXYzBYYXpmT1BXakwvSEVvWEtWckE0?=
 =?utf-8?B?RXRGWFFSd2RGS3dGbm1YLzhadXI5cFNjUG9ZYXlEVUZ0RmFOdzgvWUVHZSs3?=
 =?utf-8?B?YWtCTlh4aG5ZZFkyVTM3Uy9yWG5YTFBkaVdoaWNqUXh0bHVmMWwzZVBCOStF?=
 =?utf-8?Q?uPsHnC4LcdDUll4H3V3hIYGFVBrgRg1jR6tEczCl0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAFADE69C60969419A8A4C229B3DA53F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec89523-7871-4f6f-0b0c-08daaa95b27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 08:01:54.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1KdaUiKKGgfkzKIzK3XU2G0nhXmct2KJ57izD5nWgyguBlv1qn4k62bZ8uiV6GuSXlLHNlgFQYjIqlRhVnroOP+Z3Dc2taKgQ1CtibGMNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6303
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDcuMDkuMjIgMTE6MTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiBPbiBUaHUsIFNlcCAwMSwgMjAyMiBhdCAxMDo0MTo1OUFNICswMzAwLCBDaHJpc3RvcGgg
SGVsbHdpZyB3cm90ZToNCj4+IE5vdGU6IHRoaXMgYWRkcyBhIGZhaXIgYW1vdW50IG9mIGNvZGUg
dG8gdm9sdW1lcy5jLCB3aGljaCBhbHJlYWR5IGlzDQo+PiBxdWl0ZSBsYXJnZS4gIEl0IG1pZ2h0
IG1ha2Ugc2Vuc2UgdG8gYWRkIGEgcHJlcCBwYXRjaCB0byBtb3ZlDQo+PiBidHJmc19zdWJtaXRf
YmlvIGludG8gYSBuZXcgYmlvLmMgZmlsZSwgYnV0IEkgb25seSB3YW50IHRvIGRvIHRoYXQNCj4+
IGlmIHdlIGhhdmUgYWdyZWVtZW50IG9uIHRoZSBtb3ZlIGFzIHRoZSBjb25mbGljdHMgd2lsbCBi
ZSBwYWluZnVsDQo+PiB3aGVuIHJlYmFzaW5nLg0KPiANCj4gYW55IGNvbW1lbnRzIG9uIHRoaXMg
cXVlc3Rpb24/ICBTaG91bGQgSSBqdXN0IGtlZXAgYWRkaW5nIHRoaXMgY29kZQ0KPiB0byB2b2x1
bWVzLmM/ICBPciBjcmVhdGUgYSBuZXcgYmlvLmM/ICBJZiBzbyBJIGNvdWxkIHNlbmQgb3V0IGEN
Cj4gc21hbGwgcHJlcCBzZXJpZXMgdG8gZG8gdGhlIG1vdmUgb2YgdGhlIGV4aXN0aW5nIGNvZGUg
QVNBUC4NCj4gDQoNCg0KSXMgdGhlcmUgYW55IHBsYW5zIGhvdyB0byBwcm9jZWVkIHdpdGggdGhp
cyBwYXRjaHNldD8NCg0KNi4xIFBSIGdvdCBwdWxsZWQgYnkgTGludXMsIHNvIDYuMiBkZXZlbG9w
bWVudCBzaG91bGQgc3RhcnQgc29vbiANCndpdGggcmMxLg0KDQoJSm9oYW5uZXMNCg==
