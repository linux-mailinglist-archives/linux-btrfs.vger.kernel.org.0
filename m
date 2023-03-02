Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB306A8312
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCBNBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCBNB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:01:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E237720
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677762085; x=1709298085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rHgUf+yAn0fMJR9GqS17dt//vwiSL6Rbq+z5y0TVIWRdong6EApv/05P
   QCj85meC8J8WvlkCM9UDHzJP54Qs7jzrqUwGw8d7cCA4/4Ee9Zq0Qhppo
   cI9CrEiO6939e0/d1UMbugmquRUzq2dhS2OTX5C3IOMPgM74IyMNoCIeG
   lEojWEqr3uD7Tz6OYagBw4A/9ZHDPNjl8eGb8jsiO2oJ7AdaiaOmKSIFY
   I3sHQZPLwXeGRZmLt7L37SXM03LF7WmDyk8OpK21vFllf/IvjanP6X7cf
   zUfxCQ+xTxxHhkAg6y4x+3pLkkRIFidogatkg+UoqMZpcmr0mJa7SxD51
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224410181"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 21:01:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuAkq0M6zhrqPJOLwhOJN3U0f0UpXP2F89FEXMlgqXi5bWq2OAXAiTFk7VoHIm0hu37Ylsz9Hr3m7M+2GfF61tKjr6yEMTrHsip1iPx+l/Cr5/lkk7l3xWMIsVAHbvThHhf+zqYqge1e+ACEkjynq9tczq4EZ77vGbQrc123msKBOYznnqigiKZz0CMtiZhTPgq5zmlsovIqTvC2V/zhqid3QIJ7zy3+btNZonZdjmIJDtYSfX3Vg4U34CsIGMdh5lcvU26SDrEmhp9Hr4aIq8L5nmYIQ/6+kF5Nl2X0gNoo5mq628LcYvdk8sYIJpWMB+oHg1dS19K0SCJM/DMa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Y/llsjJvPWOd1rjJDJkjAi/MMsc2bxwKGmrb6N9cTHz7QrMjtk7/vBSmT1BFPHfV/oALMbFE32EHnY7s3MPH+c6JWamwZLnP4vi6eEXdtuQIDNi4palgmiIKRIt2j1A+9nvlRoWoMM8yKO7eWDtx69Mb/HkomWQoc/cfEAAgKdU+3V9gRVHBteNocym4NUQZKU8qrUsuMTQU3FCXWzxmyb395CERf4K6vMgsAAzL3uud0fOt4YzA+RutMHLczjJwvbixFaLL4ULuSa15ZpB+gojB4DqhUqYqb+QsP2r4ewpw2g7POK+OuI3CbHESJ88Sk40ozj3bmw53mykE3IelDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PENGbBsUSgUXvxCox3/O3Y0QyrU+wZ5n+AvfCoKeStxx8zlcRyZOHH7AienbGnd5hYvf5MLsZvn/l6u9XKF/qzGI+FocHIeaBINvSW/ika7+8HF7AB0fw9DERxwvfbAdLlrcGGtciZi+h1AVFSBU/N9qojChaePBXHzldl3yWhg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4481.namprd04.prod.outlook.com (2603:10b6:208:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 13:01:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 13:01:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/10] btrfs: store a pointer to the original btrfs_bio in
 struct compressed_bio
Thread-Topic: [PATCH 06/10] btrfs: store a pointer to the original btrfs_bio
 in struct compressed_bio
Thread-Index: AQHZTEO/8Rc76eekVkqXYhaVXFyAv67ndaUA
Date:   Thu, 2 Mar 2023 13:01:22 +0000
Message-ID: <c14dfdfd-dc77-d2e7-5761-2c93f6fdd683@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-7-hch@lst.de>
In-Reply-To: <20230301134244.1378533-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4481:EE_
x-ms-office365-filtering-correlation-id: fb6b446b-a09a-4757-2223-08db1b1e393b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIOWSpdJ8XX6BwE70JGYuzdh0yYnhidOcU2aXfMzZtO2iRiHOMAiD8IEkAHrt8yK8EnWMIrxQkaIc9BYrGPJMWN3F+rDO647vH0uR1TQV6Fe+dQ2H0Yo50lmdWPxhFvNiU18kL6++p2YCsclx1n3ZRFUVmcHKihKVrFb0Y17TiF7Uv4A57ZKeVwFTUJ7OybT3tp9Vmkq3rV533gxDAmsuaXniRlhG6cXiOqKoJkDNKo6OnrVSQxeoY7mCK4UDeCGPCgKDDztte2JjdHC6jiMmVzyCs4j1jhLifa1Xr0wxxvom3AhKHY0/JefNF2qGwV/4lnn55KFXHvBTU7yCSDdJXIF/pCk3QBpjuavfk+g452tYGLi9v/6+o9OzTWrONbWd8ehrogXUxHv5oRnelBlAgvmczJ1K3aXOVaOCXnOrENX4O/taMiRw8P3GKccROqb55H6Ic5dETxIvPrDxWgmGG6WV6l+v+mMnbT/ULeFHIOKXDryQMO3B6HWqZrRc0TzBiGlJBZBrOpBXeDTNZseNZCaeCIw6xvYI5PxLM16+lyWF3tPLgJtMSw33whilljvQ+PUJlIQMX+2D3NSOXZWOEjTfVgEXWG8yzOjrWsCxed7BCsFVwPC9mZaQSaNAlPOyVyuzOQX02VVv68VxKUbSrm+xtqtre+xpxYH6893S6j6BsObqgIREFCVHA9j8JMdJS8iTmxlhskqesqhUUctC2gsWr/xfCnlqLapH7hgbTAlB8ulwP+eAISXHQi0M5EE+uT/g6B7IJIUwAYtz4Zk4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(31686004)(38070700005)(71200400001)(91956017)(82960400001)(122000001)(66946007)(76116006)(558084003)(6506007)(36756003)(6512007)(2616005)(41300700001)(8936002)(64756008)(38100700002)(6486002)(8676002)(316002)(66446008)(66556008)(66476007)(478600001)(4326008)(110136005)(186003)(19618925003)(4270600006)(86362001)(26005)(5660300002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk1vUjBBKy9aMS80dW5JbE9kSk84N1hER2hLYTB3ZURwNUsyeDN5VGtXdUpZ?=
 =?utf-8?B?Y1VMemJDM3pyUkNjYkFGd3AyRG14ZytIMkMyN01XZVNnTG9RM1JrTm1aVUJJ?=
 =?utf-8?B?TGM0cSt4cHA3VWVpUE52RlY4c3Z5djNzOVRFdEE3TmV4SGI3WkplbVIzY2o1?=
 =?utf-8?B?VTRtbUhKc2VBcVA1UjlrUkhWMWd2RkpScG9BME8rNDFrTktpUHhJOXNPR2kr?=
 =?utf-8?B?dHV6UG1PRktJUlZNckI0QklvNVlidWZ1YVpoTURLejNJTnlHanpwMk5IcmdQ?=
 =?utf-8?B?THU0bHA0eTc5YzAxSmJjKzBHWUZtV1hxalVYeDV4SUhNZU9za2RVbEZEQnR0?=
 =?utf-8?B?MDY4dkhaZUJWVHdad0FSOStkQU1keitqNmpadmtnUWoyaEN3anBWNFJIQ1Ez?=
 =?utf-8?B?MTJkcUVqYTBIbWdkQnkzdnBKUHdoaktQa1E2UlBZUE9aSjZQSmIweFVmWmIy?=
 =?utf-8?B?aXp1UWJSL00yUXJHbStHaHB3eGtqQVpGUXEwbkIrRkVkaUFVQ1R3cFdXbVBm?=
 =?utf-8?B?T2xSNldRblhTZVh0Skg0blJyREtEN3RzVWNOL2JBTTNKb0x0NVlRejVGWVJK?=
 =?utf-8?B?a0c1U01xTE1rUEpVSWJ6SnJNTExWc1l4Qk13KzF3UThDdmJ5bmF0K2IxbkIx?=
 =?utf-8?B?b3JLUGRsd3ZvMTdhRGsxbDBoaG1jdU5TZG5LUi9VazZUQkhyVm80aUZESGx2?=
 =?utf-8?B?Y0ZvL3k1NEpxallhNnNGVFpvcndzaVVrdUczZkZPMHVQeGpVckcrdms2bmJy?=
 =?utf-8?B?U1pkY0NHdU5NdFlTbXpDa1NKTjBITDVyL21kdlBBVlFjbmc0S29NOGxjWXFq?=
 =?utf-8?B?cjI3aEtPWTRMOTMvNTVMN0ZGY1R5SlZwQ2lBd3NDdHorTkdBNGNuOXFuQWhq?=
 =?utf-8?B?YTFBd2VzWmYrajRsZDdNek0vL3ZRa1BOb20vSWJmelZsWWRDYmpRUU5ZRU5N?=
 =?utf-8?B?T1ZpK2E3aFI3TVlLWkNpQ1JBVkFmYnRDYTdDSndDOE5EbGFtYWxOaUVEMVA3?=
 =?utf-8?B?M1Z1Vk5tYXhWVTJvWUNFUTF3NmhocC9OQzdNclRZMUE2WlFWQVkvNnlpbTlk?=
 =?utf-8?B?Q0lTYlF1Wm9INTJBUnNjbXYzaFJ2VG1PclhWcHU5eHVwQXlSWXpsOXoxT0hm?=
 =?utf-8?B?T0RDbVJLYzFOOHR6WnhyVkJHWGJTRCtOSjZIQnFPSGY4UUhXdGdyYmNrbDFN?=
 =?utf-8?B?WCtUUGl1UGtxcHZ4YW5ReGVmTzZCZTdGQmIwUDM0UWtnSUpISldvdmNpMHNK?=
 =?utf-8?B?WE1wVStGdldHa2NUVmRsbzFUMlI4cEd3cHJNN25odWtPaVRiRk5sczQyOFBX?=
 =?utf-8?B?RHZ4L2hxSEZJTFFqbXBqQlpTSy83TFc4azNHbndqR1lUYjMzalhSeE45L2R1?=
 =?utf-8?B?djU2Z0w1Y0RMankrdHY0bHpPQ1RGZjhWclVGSWJvbzBCY2luOVE3Q2dNMC90?=
 =?utf-8?B?c1pXbGxrbmNDR1ZGdkgvVGhvdXJkQXZwaVVZVUhVbndOL3VlRi9ESjU1cy93?=
 =?utf-8?B?NC80dUQ4Ym1PcThlK2REMEh4SkFjOTl4TnN4R2dWUEtJZUIxV2pTWUh3UGFL?=
 =?utf-8?B?UWJOaFVlMHBtNEp3d1RUcGFreWpQVTBXU0lhN291cUZpNzg4dGRHMGpjeG9p?=
 =?utf-8?B?c21aRGFQNkw4YmQ2K3VZYUR5MjMwbUQyTFd2YVdHK3lsOFFtaHNqdzVEMHBu?=
 =?utf-8?B?SkFMdGR5ZERJa0d5eVUvbmR1R1lObi9ZUitNY25RRmhiaGRoOE92dTJPdmJn?=
 =?utf-8?B?Nk5GVjBsT0NqeERuNGRVWUNObElyak1IM1RQSVV4VzdsVjZXUk53TitiQm5o?=
 =?utf-8?B?SG84VHVhL2FvVEZKYk1BZEpwZUtrZTlPZlVwWEFmR2tBVHo3RDdHV1RXNDUr?=
 =?utf-8?B?NXZ2Mk1McVJ3aUR2dGNnN3EweEJNS1hsNzJjSHhlQlhEVFhhdVIwaU9JcWxD?=
 =?utf-8?B?WjRqc0JTVjhqRVFYU3NncVVlT081SlNLWWRXUGViSzB1eVRGTk05bUFCZXBj?=
 =?utf-8?B?dHNvazVEOUJlck4yVmJVejVjTEhLZTNtZHVIRzJ1THpQS3dJdjFidkNHREll?=
 =?utf-8?B?QmFMZi85VHBWZnIxNUYwUGZ5a21XdW1RNE0rV3pkUVRrK3NXcTkxWmxlb3Z1?=
 =?utf-8?B?RXdWRGFVV2hTVGxvMnZ6Z1NIMHAyUmVoWDRIeG5CSVp5alVRcVFjSzZjUUVa?=
 =?utf-8?Q?OTRT6e4XHE9eGzjHqtejFDE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B214087ADCFF948A87572C49479E9EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lgk3eYS170DhvjjOQFLjqgrV2AJFmxGBk388pysSRZ9QqgvYvx+ChUOwXLOlAicU1+L/Di6KgiT5kQ7N3HHOK280afEQr/p6+pZV5r16om3x67K6D5sA/cOBCdWA4HMOESYkkrRnBdXfBT52yOP0Hwx8LMuXuj34H2kv+yEe4fVSsmfDO4RmQBbT8h51zA4lehy7fb5BM9imI9djCRt6KVdl2vf+WyjpppFZ5yaYaKUBEFGhJzz9z9cozA3VIr7XTyp3zEN4yiXhyjcVE64yofTk/8AIjo5oOqoMtuo8a00rbDBALpiyUPGwcD5KoGaa4AH/KUkphP3/gi4E58/j5eIegWx9CBD7Gi6e3ITjxwW+vZJYb60aVRvse4X9/lzO7chniM4zoq1svAaTdvA1HUKAQZ3lJH3D1EFf07lnTFBwpul3c5qcGLrtS4GOMNEhq8iN+McdWnCPiBHcPWBMaG++kb48su5xsgwvW8LtpVijjOdTDLd0lKDfWHxI7Uim9wp12PhuWMlqGnvinye0Sso9uJW2rkcYgI72/+Wl+4gtNFcqgSQMvncE+PJVdb5KaPIet4zKAS3BZy+kRr5c89jpRg6LMe8CSgsv6GquIl2FvqJxn9W4l2NilEgmc3ZT3sSNj9pQyD6TKtaGXbXMYUnS/YSN4orDqptyuxS4VHtsYyV+6F7i01RIM7yh45MDlBL7XY8E/Hfh2IMjWow7hPT4/4CZE42tx98k+u1FnysgJbB/mUuH2BNnbMBwOa0inZqsFzS8YpUE8Wz1bz1u+rjn1DI7WuOjh5FWywELgYX2Vg/1NnBSRL+cKLUCgJYVpl4jZBMVNI5iITRFKCCeQbXqMUMrIPs/cw+NAMlS+lBh7txGrpY4q1N2Xdo5MmlZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6b446b-a09a-4757-2223-08db1b1e393b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:01:22.6046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPVw9eA93H82GXlN9iD9Ink6GHBy6XslJFyF8YgpONkbNo1hGjHp32LTKmy7s2TAcXvqbh4RVXBawiUsWZIiYeoeJjeKGPv9dMXPAoo5aQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4481
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
