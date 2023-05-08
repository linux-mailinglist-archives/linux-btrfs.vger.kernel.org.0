Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C46FBB8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 01:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjEHXvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEHXvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 19:51:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459272B6
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683589891; x=1715125891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=oDN4YcRxOT4N1AUmJ+tY2/LcU+V20YMEyHVYyQF4UPE/E+ci0U4Otq9T
   h91m39TC205ccUYVOMan1aw8oOvYcn112dZZ734hAUZ7e/Ah0ZYbLBj4o
   WrUVSviy0tXXxT/16dm2x4sfyfHLi8elm0Rqyv3kN8uaSEH5w3z/5Kerk
   dFbrIowjygUOIn3XFsJGDBA88/pgu+53i1vM16kFOcqv3BX1seXGgVFAU
   Q2wCdNUEYy0DPC3wd13tol8TImQ7cj/2Gmey+QKoWYx32LmGLHOK18J1M
   CxfJMHUkoze3cUw/oO1C1Rv42kMc6e0yDPMhaRWovEj6yS44hyhEQSAN7
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="228381805"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 07:51:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq3Q6Qx5vBO/DhI6gA4j8IF1e9TseWeY2AtYK1FF4SlUcWeE9yi6WzNgOHL/9g06UtC4WkpuDrNLJvbV9dUQHmqRmlHmtVmXM5Z4j2tHrmso4LfKkzohxvRVksj10piZE1kSB6eyxuB/LeUXKVsB7UNlbGtXJEG98m+9JLv622vi6KOTbUjgcuBH8vzW845J+LhZqtjMbsbMFPE39+SzaHUIDS2Ti8F2HOwqGvvwPZhwPcT9A3XIxldzas9E0WERijl6czdVd1AD/D8oJaOTyGBOx47OpOb1oozzNx4gm5in0Ihmz2TpOKJG3DGiALJ7IV+i/JTg4lX8kP0FdI6UhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CFdQu9nr6P+1hPwtCGj3cVD7LQZLDhq41nemyjHW8+DFfDOTjonDoNHcHY7rd9wt6ujNR6TXwwIzd/G3skPrI5yLBVG+Gf/fJUvfDHMe4Yuv2+NvXmRhK5X4/NZvyqnqij9J+765ngtGAPEH7QGTImd4yXzY0mfqt1LeycTQtKMBzz5ogbJHH0pMRz7L5H77i0Ntkkn/dXl7EDYTT+rL8vAAHHZsQupAmJ46tYeNfeyL3GR+iYBbmQC9ZKm1O7E9i5Vb5v0j2A/Gpyi4hh7txU66smELJgCcIo6+wFGEit+EPCn8/9q9+hoCcThxJHIl2xbeEDYR5bDuE20YYYPYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=zuSVnsIbbinW+LX1f1gF/A6mQ7L5ShtDpoVlzk5/uMn7CswOGDW5na0qc5Gp43M8/HToSRBZ9DaFiMINWqn5mSxU/YrA4fGXDR8deO6+t1j6tqb7Fm3ca9xIFcqFvEO3u6erdm+On+VM0sKKlYfZpZc77tyqIw3ZU9nOMY4QkjA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7140.namprd04.prod.outlook.com (2603:10b6:303:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Mon, 8 May
 2023 23:51:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 23:51:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/21] btrfs: return the new ordered_extent from
 btrfs_split_ordered_extent
Thread-Topic: [PATCH 08/21] btrfs: return the new ordered_extent from
 btrfs_split_ordered_extent
Thread-Index: AQHZgcdxf7KqIDxMlkujKh+9ys3Fba9RDHEA
Date:   Mon, 8 May 2023 23:51:27 +0000
Message-ID: <9b771555-8611-e363-7da8-f6358f44d364@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-9-hch@lst.de>
In-Reply-To: <20230508160843.133013-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7140:EE_
x-ms-office365-filtering-correlation-id: 3298ba7f-46d7-48f8-caec-08db501f237f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0sHJStqV8UhHd0LfOfgDmkH4qmP8zYe61lUi0QsylcwVweYC/cXR5gZJqsHcTv+fJkJiGN4AHsvbEt9j+v0yLfg8PEUuyAX9v/Cjtb6V6bB9VUN+f9vRJDtZUexcYPGH6Mp3IIr0iDhjnamhAfIxG112xTMUOPWHe1cfCrq9LiJ0u9S6G+jbpuS8T9P5pYs4fLrl67YCD/vP3fgrj00xVSHw1EEIoAVRgp/S88Ja8CI5UDX7J4bY4Vo02sCrQPtVGd7gBoISHqQUbN/8q2LYQi+s+6Apa2CVpqlAA92DMYCjodLJQsE61/Nd3AshxBdEbK+vw/fYSsO1YjTUF55PgRGgVBx97N5/sxwqac3TGpOyIVQghykIm4siQiW5Vjr+6Q/MzrLV9qMIBRZTg9a5WQ0sOdAditZm3GJY2pNFOHoVVpffpjBkXqW6FuY15XQsC4hRATcxK6/QaZj4p6sTq3nJhHqV27rkdNP/LH1OPuflIAI62yFte9bhEBu9vWZxzdgQ3MGQxSqpspaAVSFgIhwZv66El/jOMmptaKoRfNwY0OmRvGmrojvzcWI2b0lcxMHtsZ4NhrYFEGwPsLAdPoPy0kAjgn4jqgMfRnfEO7H8v7ZHxxa9tI1pALSr03meFYSlBnvfp/k6J5vaSKXKUcA5nRTjgLXgoDWLF6m5nKvddwzT0zADqcDRRwzkdCzf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(2616005)(6506007)(6512007)(71200400001)(186003)(26005)(4270600006)(36756003)(86362001)(31686004)(110136005)(478600001)(6486002)(82960400001)(38070700005)(38100700002)(31696002)(122000001)(19618925003)(8936002)(8676002)(5660300002)(2906002)(41300700001)(558084003)(4326008)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(91956017)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStlK0o2cWpZUTgvamwzSVhSVThBZDhYZ0hoM2hXbWxhV2hlZ3d2WGg2dHJB?=
 =?utf-8?B?c2Nrenp2aFVYdVZVSU1mYVQxNE42ZkhsQm9HbUNSdWlFLzhGY202M0hWL3Ni?=
 =?utf-8?B?d2laajNBdVBvaTdHMUc0cStoL2sxdVMzQTI1YVFjcEwzbGtTWHNDaEt1K2gw?=
 =?utf-8?B?TXROd2hNellQUzZia08xSXVQYUpGcXJjUFBtcE55anZNMWpjd0xXcVZObkJK?=
 =?utf-8?B?Tkxxc21NNmw0MnBnTjdid2g2dUozZU1nSDRsdzA3eG9LQXdwckRHWERXSU1o?=
 =?utf-8?B?V3ZMbDYwRnd5cHh4YmhGekZaMDYzdThyN0JvN2xMaTVLSFFTbVBoK241clRk?=
 =?utf-8?B?U2xPa0gzSmJJN21PTWxPM2htdjB2WUs4d1VESVNqMFFmY0VJQjQxZVQvRWVh?=
 =?utf-8?B?NlFibll5RFYra1puYjdTSUdaa3V2Smp3TTUxZnRQWEw0bEYySXFpcnJSWU1G?=
 =?utf-8?B?eWU1L3VzbWlJZnpjTm8xYUhSMVB4WDBCRzBjRXJsU3pMOUlrOWRYK1J5SFlW?=
 =?utf-8?B?Q00vYVhOMTgvcHN1TWRNR0VKUVYzalBsL3k4dU9vT3MzQVRLb2RyWnFSR2I1?=
 =?utf-8?B?Tjh4VzlHeHd1a3VXMGszR1N5WHlBdmx6SkpLQWhWLy96bGVJa0ZZVmJTRGhn?=
 =?utf-8?B?MHF6RFpodEZFaFRGM3VVRkxycWx3c0pOenpXZElXYkN2dzI5RUVJeHVWR2xM?=
 =?utf-8?B?enhNcEFYbnhhc1hPckhDNWNHSWJwRGdmV2Q0RlFMemV5a3BycXkwcE1rNEZo?=
 =?utf-8?B?Zlo0anYzekdHeG9mWTdqT3IwdW1wTDBzU0pxS205a1F4UzMvUHAyUGFSRjJL?=
 =?utf-8?B?Q1BHWmFoemVWeGh3T1NXU3NGWklFdHVnZmEyaGhiQTR4Zzl5L1R6SERiRWd0?=
 =?utf-8?B?b3JLV3ZOZk4xbHBER1VCR3dndUNuQzVFS0FZclRqSFhhNCswNzZqRWx3cjJX?=
 =?utf-8?B?Q25DcEVndWpoeUo3QUx4bVNJT2tsdmNOS2dZc2J2RVpaeFRpVmZlZ2dWekRQ?=
 =?utf-8?B?ZERyQlhBL1dEL2lJWWkxWnIvU2tlUW8xTzRNNXEwWHFSQ21GSkVhbDltSHRD?=
 =?utf-8?B?Y1prVm02aHc4NWswZ2doRE5lcEoyOE5FNVBkeE40MU5WSmZpQ3RQVS9vWDcw?=
 =?utf-8?B?c240VUt4aHdiT3dQTXg4Q3dmOGJ2ZnpwWm5VQlkxK1V4L1ZON3p4dzJiVVp0?=
 =?utf-8?B?MUlOVlhpSEdLTTVhdkwvbmpEQUt5SnBiRElyMWRRakFac2ZiQlZoQVVMZ1Nz?=
 =?utf-8?B?TjdLTUcvdk96UVovZnhJaEwxcGIzUWxhN2huVTFtYW00c3dhc1I0bnY2R1Rl?=
 =?utf-8?B?WUV2ZFFkQXE4d1dSSnU2V1pLS2sxcGdSN0gvekRTVHRiUUFiTUt1WXFPejFz?=
 =?utf-8?B?UVFvZUMxZGJGdFJiQUprenpnN1hJdTA4bHlZSnRBN2NUbW9KWDRoWGVLdGhn?=
 =?utf-8?B?OWxZMGtxUDFpdEdYZy9PWFVQNEtuclZDUUIzRkIzYWJHUCtZbWllMlAzcDBq?=
 =?utf-8?B?MC9aZ25HNUVtUkI2STVsNzd3WlZHaU05dHZPTjZGUVZZZXFqaGpLMVl5T0dL?=
 =?utf-8?B?Mkc5dUYwSElxS0dWU3d4MGxwVUMvV0JkT0hMa2JqVlVtVWZISHZNT2UxNlU5?=
 =?utf-8?B?czhjNWZBWk1RNzFSMm54VlQ1OWVrWTF5Y3k5L1NGa2tacExqbmdZRGZOWWNU?=
 =?utf-8?B?TFpGd1hvemtUY1J0bE1makdsODVxbStjc1VZWXhXdFpuQytSdUVEclErcGtj?=
 =?utf-8?B?amI5ODdLNUI5WGhIbTJ3VXV0NGFJMUJnV3A5OXo4WFdGSm8zQk83TTlHRWtu?=
 =?utf-8?B?N203K0paM1VCMTM1SFFlRXlweVRwcjhMN1c1WjdDWHkwaTNMcFMyYTR0VTh3?=
 =?utf-8?B?V2ZuZUl3UzVqZnBuaXRFdVJPYVVIZ3RwMVBLcUFwaFpzcTV6MnVYdXcvR0po?=
 =?utf-8?B?dHBwTGJPMW83NGhOM0FvTVpwVUorK2RXWUxIa0VxMzVPMHpPMDhyZ1A2eits?=
 =?utf-8?B?dFNhdnFaTFFaVW1FOHNNUFFUaHYvYklNTi9yWHp4UTFZcVdQL1l4N0pEOTNq?=
 =?utf-8?B?MWFTNGdOKzhHM0xTdHVQOUZrZ2pFL2cwMVA1WnZGckZpMHNleTZzNnpYQkpL?=
 =?utf-8?B?NjRWb3ZXNXlXdXF5V2NjdkxwVWVPSUVrNmd1cG1nVzhkVEUyYVdRMm5iU2NL?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C7F67F93FC64469C27B1E832D7D0C6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PHdmqEvNcLcOhNRz4nCbmLHPpRIoc9zbHUovCdu/B346iJIOZQj8poPZyha6Oj2X1A3b1yOjkb+aNqn+7j87zKMpKm0wucl4mHH+cua00oYogXLL7KNDVGzHf/0Wp9wYwqXkveFStPv1+9wq0e97sbfS42sxE5kT6QelK04mB4yf3cHSJyVGmmyQb1NuRbHwE3vFe/qIrCuWXUANjFYJ2tg+ceM+veW01e18MpA0sFsr5DnU9Ap0/w00Du5PsxXWp+1Py4Wmzvy+uPe9zx/APVDFaEH0lkU3/OJWbWdVA77bCzzHIcaBcwLgrsSA5rphaREr6Az8vZXXSz9jb1TJLkEDBdJCCWWFYCGv3A0z3PY37CvdOlOu6r4sudh9Q0w5AgjryGYzPsCZ1E3pT8vLe1dR8q+DrjKzrrR1XSOp130lvzKGhbbhxDfeT0BMRtJRCwBcAUjqViTJnuMLfbbwL59yTZSgyxik48RgTSaIg6WbzGrRkSf22YoJ6juCQZGaAShfhsJD8Ps5wZ3zZ02JjYlk8Bxz8DhBIFziuSDoV2j2zeJqCCHDmI/NJJGHlF5175/QQ1PWxfJsv77arAfYmUgyjuvKi62JX7Y44i2qksL48NBCCdfyS/uIXR+cWDuKa8nNFwPFBL4xNw0ZC6+wTY8PORkUO1zxJfrIbmtCYOUTNfH+vv/XGPcRUQl5mf1Aq9CguyWzZ2xFlXieAe0855F+OTSyH8QrtnV9ZuXbSbfJtPPRur25TuuW5GjMEIUcgEMl8iC96OGZvd67R/R+Ou6XLuA74BAIQHF66GwNYYVJIce74CF5s+jaYlzyNcdbwP1ko4ogjiQQZcI+XGi4FYdKnkZsK5y3Knn7Jqc5FFCUEu96ZR4/rs/9DDxi/F8p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3298ba7f-46d7-48f8-caec-08db501f237f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 23:51:27.2671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 372xtLVOH6xIF3XsabgKvHbMGuhOM+1+yMD29pqpuDq48300K/Uzl69vUxEJApKMuc7AMDY+KazTnXGAgyD+W2Ca5URXMjo1Do1wFjxvBgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7140
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
