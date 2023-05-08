Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005A6FBAF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjEHWSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHWSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 18:18:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B446B3
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683584282; x=1715120282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ltPkAMvdRva3UZe/wHy52oHJba4K3Qa6i+W5F9N8B4Uf28GBRLseKPrD
   kfSREJIcJS8NZoYcqV9MJaHrlWG0sQCHRS6mD17CDCL0tsw8tr/hpFgKx
   5jKTsqtT3f3dd3/nyCmUfKf7ISl9mibpvMlWxTtAJHSAosTALAS/pscle
   WV54hlu4b5Ijr7i7bzWHHe9mgqZRIFY5sS3vnzJm2STS25CkUBxuK/FC+
   FVPRal6iMndm3pZzLVh30M+USDvOXiuyLjPkAtp0xetVoIU9NgHpl3lVA
   uYFmz1LmZo+MI68Qy+RnzDYkgRSFtF6tFNx8U5iY95yNCHpMSXHr7XgIW
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="235153675"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 06:18:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbLaC6EOfEWA/itVLDUf1NJnmXSec1aVWRsfFzCUGr9v3uEJqg8b8F2vVjNS9lwj+NlvtIy0oit/IOgj20L4qiUD+jRuzlN9ycw6UjNomzJMo+y2trmAvXWxA3hwtMF3U4yej/8dDoat6i/MLK50GzrRRKdvGN+E/StI7pkyxUPuJW8pCW4LF0jFwse++wp4s0rN2dR6QvCaL5KteDsU07t3zgysZrN59dM4yYjVl2ektnCRSG094QSYWT4YB3JoldC+I+9jCtMeoI2+WDj0Z67h/WK34rygViAKnidMhOurf4KquzSEwCvUfzaQaoaJe5CGjx3GOTZc+2Ktz93gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Kl9HL6I2eLlw/th0UkXvNf8+AR+itCFszM1zQKuaDYk2XZAhftlyOwB3mG3zS70tkQ9dIOcghO2N94lGJuzjrSvfFdz2Q2mJK6KqDo1DqLHvZ3SzIn0Rj8fyDpm2NPcBjO+xiIACVrtKtiieqO1eCkt9s5xjZy3QIIbOMYZ1/z3nf1IJxTmCFWa+eJnIa51B7drKHeGFMWwDUhDmRfzY+S6vuA5Ar60T/b8bEebP8jxIkf22062uuNSMOt091vMsJS6rk3leS9WXQjlEI0dBHHwK2D9yLws11O4IM1aPPZxLT/l8t95GSVxZnXusMqOEgsdJCjk+nj6nwik3tyu5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Mh9vEhDh9SAG7SeN5+sq4rYewT+Cs5RyQiKpbsljGEMAjhlVjLgWwp+Q8z73hTg3eL2iMuyyUVPzZTC1nb1g7kGQSGh27gtWH9Txn1CD6vfwkDxIYNvD0H5pqC3h9WfBINJQC2w/hEHHweiQuw7UaxCM/KJaTMZFAN4ks0llGcw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6619.namprd04.prod.outlook.com (2603:10b6:610:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 22:17:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:17:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/21] btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED
 bios that get split
Thread-Topic: [PATCH 02/21] btrfs: fix file_offset for REQ_BTRFS_ONE_ORDERED
 bios that get split
Thread-Index: AQHZgcd/hey0pKd0B0quOy+oY9ah8K9Q8lOA
Date:   Mon, 8 May 2023 22:17:58 +0000
Message-ID: <01fbd5d8-c2dc-d9d5-14dd-909c2218d5b0@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-3-hch@lst.de>
In-Reply-To: <20230508160843.133013-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6619:EE_
x-ms-office365-filtering-correlation-id: d66db970-8b74-484f-acbb-08db50121448
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJczojvUn2uA/lycP96+1XG7Pu2mtjQVh7vnXaNd0fxqcC9WXPidzLSczKZjNZHmz6rqi9O2SDerHnzypAEtFIRQJg1UliH1+sSQd6RQPsskIz/EaAwM6vYe5YF2eQDDOg+yp1BhiRjC7w1gXgpV7mRG4zTlyU7Jj9YoOdwXnKjSdadFQtRGPy08m32C6SXLw2CspjzyFXy6yeVH9jO9KwXeLlR54kUWzHx2GRn3DpUyzEWSsxeEn8kZK6POy9EZ4F2hxLpR9IZOi0opvjPOk3ru3R6+VnTbpQBKPDya5tA0Z/3kYv4ZYslI4Fr+2ffPTWmzKTTNMixZ1QFETCgeV6b5hdofTAUTkBb+y7qpESs5hfYAwatSfrc77pFN8goXnVjgdQRKDwu/Q762Y0i15ucisIZPJAPFssKJtDs30g54NbY5xer0JQyxuis/xYN8cKTwAUD9jPSJC2K374LiydvFMQadQLNdv5XkC4/PYIfeZB8tVnq5u+d1SHO14oZwmWyIgHuSUuqzflL+MnCDYXhWBUSezDCKL6mHXsiHuoSButMl0LocrAv2r9KE7oVqokT+NHTxZwXBPsqaKhqUV/ev9gWaGDtjqB7Ve6In/Tngk7d6ZYbeq+ZiuZJW0eIpVEPhmp9P8lVrFl0CE3odXiJmb3wosPSywA0q9+XkZJiVh85mKUF78upD4GDLhR4N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(6506007)(6512007)(6486002)(26005)(2616005)(36756003)(38100700002)(122000001)(86362001)(31696002)(558084003)(38070700005)(82960400001)(186003)(4270600006)(66446008)(4326008)(66946007)(5660300002)(64756008)(2906002)(8936002)(478600001)(8676002)(66556008)(66476007)(31686004)(110136005)(76116006)(41300700001)(71200400001)(316002)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0xLZ0VQK3hpb1RXTjU3UzZhVEV0S0tLOHF2RXdSMGZHU0x2VnhFcG5sdDNh?=
 =?utf-8?B?bFRvcTlzQWNYTGRHQlFJQlh5cmNsSXgzTHBPb3NQY25aYWhBRkVYYU5wcWVt?=
 =?utf-8?B?KzJSZGxoZkNDRHYzb3pmeXNFVENPS1ZxYlJsNHh6UlgyYTd1ZnphZmhRYU5K?=
 =?utf-8?B?b3lXb2dpRVYzZDkxQzRkeklac2t4WlRUdENPdkZKQVFjbXBaSi9WUzhOTWh5?=
 =?utf-8?B?ajMyTUFCM2ozcXhxZmhiYjNBT1Q4U1NRYlVZbVJ3TDAzaWZkQVdNMTZXaXc5?=
 =?utf-8?B?N0FtcXhmbjFwb0ZyMTRETUJTL0k4ZkxQMFp6YW1EYmxDZ2ZBdnJjUHNrL3lh?=
 =?utf-8?B?bmNKS0xlblRxaG93SHg5K2JhemZKMXV4aVYvSkJGWm9hbmVYOEhqYXdHdjBs?=
 =?utf-8?B?Y0NpNm9jQ3poSTZCeGozNUlnbkt4VXlYLzFIb0FibDlmZ01NNUNPMEJ0NjJY?=
 =?utf-8?B?VXBiZmZFVHFjTDNxV0FCdmQ1NVZ2Q01QRGt3WXZlSXhDRzI0SWdmdVVKRENB?=
 =?utf-8?B?UGtGc0lONDBvd2JkWEZ0T1NRTWJNZyt3ZFZQM0NsQ3MxWWUrNHd3cFdsejIy?=
 =?utf-8?B?Zy9haDVHQnVIeUF2V0xvRlhwUERGNGVmMVZGL0M4L3p5TjcyaHhEYk1KNVpi?=
 =?utf-8?B?L1lpenI4U3J1em1ZTmgxRldObFgxcnFneFRtQlhQeUFpaTZ3UUNSWmh4bncv?=
 =?utf-8?B?VHhRbTB1dkJzTXY1OWMyNzZKY09JRmI4Z3hFMUhtazUyd2VleWttdEZpL3Er?=
 =?utf-8?B?bzU0RG9PcVBtZGFrQk1NZGFtOEVnRUxpbTRmVk8rSGQ2NThNMTk1RmtnRHAr?=
 =?utf-8?B?Wlh4c1kzamZBcHZmSHdjeUQ0QzIrK3BhWnZ1RGV2bU5ESEpBZThyb3YxaERr?=
 =?utf-8?B?dXA2cDAzS05XYWQveXlpVmdQM3l5cXkrK0RPM1JrQjVrcEttT2FMSUd5bFht?=
 =?utf-8?B?alhUanFDOEp5WFhWZXVnSE94RGpWdWxnNUUrWFA0Vm1KRU0wMUVOSDIxVndF?=
 =?utf-8?B?aWhoY1p5TFhiZmpHVUZ3cEJPMDhIYzhTNU5KWVhsOGN6TlkyTTZpUDRiOEtY?=
 =?utf-8?B?K0xnM0NkZE9vcHUxem80bXk5SHMrMFJpd2hqaUJLN2x6M2l2REJkNFZCbnVK?=
 =?utf-8?B?SGdXTEZzT0hHdmN1aUxSVGRIUkVTdEpkcmdkYU4zdVVhc1pyTFB6N2pQMG5I?=
 =?utf-8?B?bDVpNVk0eTk4VUkwZXVSSHozcmZEOCs0cEhlQzNqMUpsaGVIdGJsZDJxcHZj?=
 =?utf-8?B?T3EvZU5rVDljTTlZZnFYRWtFWS9jQUJ6TnQxWVNXR1RXMUVMS1ZwY0crQkNv?=
 =?utf-8?B?SFFoNkcveHFPRHdHdVhnNzNIa1kwMzdjWCt1VkowanIwRjNIYmlQdjFZcGtv?=
 =?utf-8?B?aFlnZ0l1T1N6LzM2Mm8xOThlZWhxWDdRZ2ZOMGJWZG9hek12c0JYREF6dUNm?=
 =?utf-8?B?dGgvUktROFZRbDBNWm5IZ3huWVNNVnEwUFNpdjhKaXVtSmZIMDh5SWpwSHVV?=
 =?utf-8?B?bXM5R29BbFI0Y25HeXk3OEE3Z2wvcDRwM2FmN3lFV3ZQaTB0VnFQN0owL2U4?=
 =?utf-8?B?Z0NkRWg1TDUySW91TnJTQmw5WmNTWTJienhmNkhZMVk4Z2srVk5kOHVQQmRu?=
 =?utf-8?B?MCtmbVUvb0hUSGhlckpOQmxpYXZOWjhFSjFOSHJHUTFQM1VYUmJxOEpDVEtu?=
 =?utf-8?B?ZlNxQkRRNGdyN0hia3NFVUlyZFhtMkdzVGFBWVlLbnZkSkszaUJwaXhLcGVE?=
 =?utf-8?B?ZWo0ZUpoOUZqVFJWUDNHRTNSS1BzcHBIbHBLRkd3U0tuN2M2RXVDSTFZbitN?=
 =?utf-8?B?eHBqcXl4NXF4ZXdEdTBqS2R4bjArbHZhZmNlOW40YlE4ZU14R1F2UTg5RDlB?=
 =?utf-8?B?cVF1SVlTMU82Nkx3UzlIanVienV0ZDhnWTNkSjByakVYWXZadG9YQnNmMVgv?=
 =?utf-8?B?UkdCRWdvVHFPSnIyR2V1d3hkbytoRmlnZkxWcVBVV2w3ZEVPTks1OHM5Wlla?=
 =?utf-8?B?ZDFPQzQrb25EZE5XbG1vQkgvQklLZG4rYVBBbVpIWVFGL25lOTZSTXRkSWx1?=
 =?utf-8?B?MUpCVFoxREtOemRxMVMvUzRUYktwQ3Roa2lJbEV1NlROeFFIQUJralFjRjZS?=
 =?utf-8?B?bEpIWXhXZm13OC9MY2FRUElvUzdYeEl0dzdVV3NiK3hoY0V3TUkvWFBockgw?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00EACE9256EB454A967DCBC736F9B6AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i00zvV0ZTzFSx3tvyI39pgqAFNT4aMXygDhw7lo9Zi71Oy5PrdPsi+9uyC1fHQInG3Om2RuGtRTvrj0oF+ntRdCKi4wGTCS72ipQgzZm/fERiL/PfuEVizSkMEo/RWqbtynEo3XpbbiwIH0PSk7qH1DzkPRGfhkIxCVHoUDJPH03QlucS0YoIaFLy1ass7L+a7IGahUSMeDIrmur0eH8y7dEsyN1QOG2FSi8dxrjBor3JSGqS9iDoOghoMyU5BcLbyzu/1pV6ixJ+HiaNKzO+ONrHapKiuTauKytnww+8d1AmRYx7Pq/4VUciGcLqnj3xXB/iYJoM9wawEbUg6VYXWqukfLQYznMJXnpchXZ1N3dm3XTK+NgcUmty68E+4gSsIufzx9JQj1XH/pB6f7rgCzOca1SOAVF82kUXYqXghg9CDe4z1HjdAjFrjb0rZaCalNBIVlZgcQHVWDhfFASElgwxBWl71mlkxqXv2W66lIcP3and4U1grPx4iV+vgkT5I3BLjdlpV01LmPFwPKWOIHSl8EYpvA0315ZevMp1hO/VdEAviOkljvC19Y2m5KNKoLYBfB4V9KMsCHOlpPcOaPYoRpA85nsUppAh+3hyQLcCVpsRV253gEuYNQ5JUnCNtyIYtEcUjq7V/D6zrH0RjcGYOWAZrOfKEBlSwfZnxuFD4qDuaRvDj7Gu7EEJZKw9HgcbK0YNbY3UXvy2njafsY05ENFstD+1sAa+Ubb/Nhqm1tevPX0+rLIiolU62V9ZaEnYOG2TFEgfvCeJRfuYyrj4YuIk8u/oKsDtHc2x5Ii8haqEb2Z8WI+fbgSmhltg5DUHGw6YE/G8zkUkectpeHh+GZK9MEcwngYZ7zBLatKjUuoufy/qSOcaCwoRIwM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66db970-8b74-484f-acbb-08db50121448
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 22:17:58.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3+4jZxUyLT8CX2CUu6Rige+okh+aJ8NO3PLfKkGyNgLYKJ+t98YLPTgB6idSt25Mec7p0NG7oh/iHsIMtNFp95CFVesF8AhF27gbsUEiYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6619
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
