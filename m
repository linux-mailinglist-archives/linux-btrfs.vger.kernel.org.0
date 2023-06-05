Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92834722306
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFEKJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjFEKJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 06:09:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB4EE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685959784; x=1717495784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rqRBJ6XNO0op4QQMqgEuvTl+mHhbclCOOMCUc7b6quQbWR6kBU8X6F4f
   KWeRLDlXTLuqCJ88d1K3+2vEoHOO84iD2jptx6B1jRoGDMcaW/1nkGj8Z
   UpjV9XZJbQQWfHU54xe1aM9C9JxEYnLIi0gRGIYZSTkTLMrylk9XTWCq7
   nOqdPQjaIydHYajuceWJT6+KI0Rg+3z29EIYcwacgCSGOyFd+a9jFalxT
   iCmsYkmnQa2GdUHgO9SuJze7ctPjr6uSWM2GaV/PXFSMJHXk40pK51QK7
   nxO9cwzH/70EEtSyIfVrAYgHEdZ+83kE5uOQEDZNP13pzHAlFKmGadw2r
   g==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="232454943"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 18:09:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrDqpVnoUbPTKRsSR0+7XUR9AE9kls3aHM/7zVZw0ec6zXBa3hY7DHaA6CxmMPq7qICGO7rZbXZbCC6Sm1RSll14ZXj96YAiJC6Oe+NwoYQXyPI6nVB4/wjTiaJeFZMZpHvtFN7DRSzN9LdDBXPDKy6020nf+EbjwSb86Gu313NnWViOq9fTEt2wmsfbYZ5KlmGAdcG9/hVCLsU37f9/+BjXOjtTQEs5fFAHaF5O97t+oyyS+dxJGHfA1B8p2N2aeolYUkG5mce27F4t0GkCKKo+vQmQ18X1miqfZ5vqeo1UvRtk0GgVWebxYhZcfzppY0/UrfGSKv/goMJB/Nooew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=apnPPJSE2RbAcfWHANy+SOvmHx8JKI1o1mgiLAwVUq5Xt+KDmvlPF7GwGOLsBdIfdkfLPLAAGBAPc6c6O2oakBiWXESHqxC0tpFP6OD23M3/+rk0/BJ5/4l5XXkrZtqRCT7eMQRJBMkDR/mZQX80iaTwYzrVkN1OxmpEFtOj+2Ta0rIYwAO+3ceQYx+vgVljyHK9/ECgPjk8AUFFcYoH9Jf1j6q4WL3+Kl8jBQGDD8QSB7eFA7AZ2SHbxd2S+2E5Zi1jOoqYsyu9sRFLutv4KPLFNUYNRXMjF3eJpXoCTECAdH6JeoHK3IK+EJTRZB756Ba6lx+qxieBO47dMyNOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RBWaBJ0SIGG5W3aed38UHWVnXhX0iQNGey90btAmi2F7wx2vZj/rUcGv1d7T2Hp+gUsTpTlDonPtoBcseRcrSQNmg7SB5WhexOsIogoqTB1w4GMGQ9ZvIdvw89ngLYeAqdFlWZ584+RAmh9GS4tHsmlymHEzqjWDV5JKHIZioXs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8894.namprd04.prod.outlook.com (2603:10b6:a03:53b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:09:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:09:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: introduce a zone_info struct to structure
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH 1/4] btrfs: introduce a zone_info struct to structure
 btrfs_load_block_group_zone_info
Thread-Index: AQHZl4rp5yFIsbRYd0uSTaP6ksQ+m697/JgA
Date:   Mon, 5 Jun 2023 10:09:40 +0000
Message-ID: <6923d907-ab44-948a-a488-05e20013523e@wdc.com>
References: <20230605085108.580976-1-hch@lst.de>
 <20230605085108.580976-2-hch@lst.de>
In-Reply-To: <20230605085108.580976-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8894:EE_
x-ms-office365-filtering-correlation-id: f7b4c0ed-6f8c-42cd-1eb6-08db65acfa3c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGHEXv4Ng96oAubThp7+vJFtdSWDn19/R2gqt9AH7FmwnHucb9w37eeMNjjoHaOueLa30SHJfKNjEVaeSy3IXqR0KtNFVfJsDnLZfjOHADaoMw3Z9WHyO1wX1bc0ekCF6eiNjs+BUu7U11/HhjdXjxZ2Y0lDkvwj/alYcWO7Sy8dmSLM7MQ+yOUsg5Svp6LNilpk9lPFZYHpuVdat9mZ4jzZK1D4I8pRQfjqpn0fUK/SkNmzMeJk/clAFhia9twQYC669wcSUpj5XLqZfADOGzF6rFcDn+ShuuK1kGoDaFD9uRHJSvwvCegmavtcCum2YgGT/BedSEbzAF9ACRpKhCdnirkgHfKezpfGVE1yXmaf3BZv4SWimicsYZMAGT/bceq3tBsxnzO9PtZIvCVogt4gEjWQmhJvZG6wChFW6NSf1EazWBXFWg8U6iozT2HH5A0oUtWmqTZNe75MmgUDs87AN5NDXhQMjRoCQSWGcQC5o9K8pNKyLqxrZpqIOjwaLGWqlkat+IFC5Olc/BCc2wkPoOnGSfl/BVtgQIR6awIV7w+1fZh+a2WcrnV7VcA+IljdFR/UsaXEwo6pnwZ/aiJoa+uKS15C5aVuMcwn5ZIT62c5X61/ov7TZL9UMcyP7V+9g2cCT2cMIUMCr9RekzXPz5BHOKPVEVRpVuxJZplQvfVXfCK5OF7mhjeAUq4w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(54906003)(110136005)(71200400001)(478600001)(8936002)(8676002)(5660300002)(36756003)(19618925003)(38070700005)(2906002)(558084003)(31696002)(86362001)(4326008)(122000001)(91956017)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(76116006)(82960400001)(38100700002)(41300700001)(2616005)(4270600006)(6512007)(6506007)(186003)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhTbjFvNUUySkFYbU9vaTVIYkpCd2dhVUQ0d0phZmpKZ3ZqVWcvU2NibFEz?=
 =?utf-8?B?djczeEkram9kUFlCWUlRRXFDVlFHRDBxbDFYQ3prc0pvMmk5WSsrbkVaZG9q?=
 =?utf-8?B?RXgzOHM0alpFTE04ZVk3QUtxS0doN1BVMFV0blZqdVNxUDh1VU50eUtWK00y?=
 =?utf-8?B?RXBoSkwwZzdxeHdGeWp4blNRcDNBNHBMUnhjZ1B1ZGp2QnlGQ3hmVS9QM1Bz?=
 =?utf-8?B?NzJ1QkNBUG41WUFaVnVjdS9mQThzQ0JwNHk5Z0RLTzN6Zm1rcVArRVI2Mm5Y?=
 =?utf-8?B?MVBPaXVtRmUwUEh0Mk4yc2pJOHNzRHdqMk1LazNOWTRsTUZNeXkvZ2VsOENZ?=
 =?utf-8?B?UExscGxNZTd0VUdQUkk0ZEsvTVRJUlVjZzI5TnBLMDJacnhEVDZMUTVkdFJ0?=
 =?utf-8?B?VzVNUDZqTTZoTmpENU8zY1pOYWlyZmZrWElXL3ZnbFJxekwwOURXY1NLMklw?=
 =?utf-8?B?YWgxWUpoc3Y4d0xyVFBNMUJObUtTRFdXVXRhT1F3OXJwNFhuc2haQlBUOFFs?=
 =?utf-8?B?c00wUFBQODdBRGxUNHVDWm1jblg4MDFocFFVMU10SDEyZVpmdXVYL2tSQnVr?=
 =?utf-8?B?Z0xXd2JQWXZ1b0xka1ZrNG1FekJ4UmFwSG1HTzhHUE9CaC95N0ZWeUY2akRC?=
 =?utf-8?B?Y2VQSmhkbmdLT3N3d3pYNzhpUGZOaE92UmphTk9FRnM2S1VPSkk2UXlDZlEx?=
 =?utf-8?B?d0p6YWdHUm1STzZ2UGQ1WXRUMWZ2bk93dWZmWlNJZjJJSjB1NUl1NkFQVHov?=
 =?utf-8?B?SUVnRXlFd3hmUUQ3VEtNcXN1WDdGRmMvVlVTa0s2VVZTY1VUQ1EvL0hRdWFP?=
 =?utf-8?B?MXloWUpZUVVESVVoSENGTG1WRnNaemUzNi9OSGVDdHFMSEkyMlRXWTJsTkty?=
 =?utf-8?B?cTNldkJMYkhWS0JOK0xOTEREODZCRXN5eXBqYi9BVjBYNU9CcFNhOEEyRkZj?=
 =?utf-8?B?S0hEd2FrL1NlcWtydmtJVjE1SFltV1JIVHZxM2ZxSzZXNHVmbStTRk42cm9n?=
 =?utf-8?B?cGl5R2ErWFJ0MGIvMFUzU0xkSVBpZGN1QlB6UXhLMnd4VnhzOHZsczVBbHQz?=
 =?utf-8?B?U0Y1V0hhTDg2VGNLWnNWNEs0SjZ4UjVpL093eUpocGJnM2UwMC95VWd2bTdB?=
 =?utf-8?B?MlZGYjlzNGFXNUVGb2JXWUJXaEJpQkVpbWZkYjF0RDlSOENIaFhQUjlBRGxw?=
 =?utf-8?B?M1JiYnBTc01hRng3dmdhVHBlSEJqSExhOUxqSUVGQ0dSblRET1VRbStsdE1i?=
 =?utf-8?B?b0NRZHM3UGJQT3pJblVjSjhJc3dKai9tdzg4cHYyZnlnVHlsb3JRdWdxYVRF?=
 =?utf-8?B?THBDZzR6dHBkcDBMSThRc3ZvdUFUTmlzR0hvbHRhU3UwRHpMY01JV1dRWjBu?=
 =?utf-8?B?UUluNmh2bHg5aWFJZEl1ek5wbFEzN2ZBQ05MMEdBL1U4TVozaXp3UERaV2FG?=
 =?utf-8?B?ZHhqdXdMTmVHYng0TFRFUm5HbjdLUHJ2em5Xa093OUdSNEJ3ZkU5OUp4SHRB?=
 =?utf-8?B?by9KeUJRQkRqMDlXSHl4M3kxaTY4UVZUZUU4ZVVzVHhrZHRHNDZ6allpa2do?=
 =?utf-8?B?TnFKN28yaEJHd01qVnEvbVNNYTU1a1VJRzhldkRhRXk3RFlUaVl4UEd6U3pr?=
 =?utf-8?B?Z3RwMjRiLzQwbEQ4TGJKSkxjMjc4Q0JQeWN5MmFmMTlRS0Iva0pMVk9RY29V?=
 =?utf-8?B?czNHZ3FYeW90UXZMeEpDbjNxTEtYcjIvcFN0L1NGNlM0bmdPdVFnT0l5QUw3?=
 =?utf-8?B?MGJtelZteGd2bG40ZXJmc0NpbDVwYm5TLzd1VjkxRDQzT2p2QUJPaThBclho?=
 =?utf-8?B?VkxuV2JiZ3VtVVJnZzJINmZNc1lsd3Z6MEFTTDlUU0RuMCt0VmNKSTBIM2kx?=
 =?utf-8?B?bkhmUlFYMTJ4cWZWbGRSMEx0Qlc5ekdCWStzcld3WmlzcmpsSE52WGRBSnFQ?=
 =?utf-8?B?YjhXRzlzS21iV21lYklxNFNWUEZwaSt1d2tPMHhkbHFTelNIRW9USGN1TFlC?=
 =?utf-8?B?dXR6YS9RWjJhcDl2ZWZMTm9vd3RnaVJOMlNTK0J2S01JMktmVkhzQlA1alYy?=
 =?utf-8?B?NHVNMEVUY214NFBBWGFDMkpYWG5EdWRmSHZDSG4vMnFKU2N1Ly9SUkN1ci9J?=
 =?utf-8?B?ZUJuZXFEajZic243bTFBS3NkVWVldDZyQ3VSU0V3K25kOVdCb2ZRWEtUTWdm?=
 =?utf-8?B?VjFuKytlZG9mS3B4dEJwMmZUWTc5NU52dHh5QzBwc0lmNTdiajZBcldDMmlz?=
 =?utf-8?B?QnlLYWtHbFRCVjZwalUyeGhEa2xBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6651BF13199140A50224E895609AB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qMQJAKhuUntLehQO2gjM95bXnJSKnJLKa3MM9SvMF8SkJHxa+1wrCAzHRWF9unATe5pvt++oQUC8ESCS3c3zXBcfFbrEr/+dqudQmJO/nyYfdM9O6D27dn9+5fLB/gjU+mHXtgzG0Bfr0n2tew1/kEK+fnG9Xt1TffqKjDca34u5J0C6n1JOiK4bc4oYzq2ZxQrZiapVqTPSbeO7zynUuW8OOWSwckdoYSKTgESjXRbTq12pkCn26qwo9PRli/GqoUQDsQETLrNa/9GsEvBUUmRc/XvQyGgLW6NJkv9e4E6pscRrzrDzxmGOvoWo3rh0p6lNzCjh84Xop7AYxI0JPA+GsfMVxbWMLwTCv5/3iA4+hn1O/X1GEudItBRuEysiN7IfKsz89hPN3bCyvCIUZWPX+zSNMhJ2nxSkKP0BfWNCxcpF9vg4ZJmD38jG4lZ8v9aoPSLdXETbBfOrQfoxMea6OfdElsRnx2p5e36RcViDtJwmXbaGS78fFPYYJLQGfXkvEgYp6b9pPlVV4TXIV/Yh+JEEut0bf54iYgBC06NS6TlyG2fAfg6u7sPgvjobCEK+kHA00LzEGPtt94u0hwHGINX82pf6vfNLHzbv5bx6nR3XSad5Bqvyzg+3iEaYVu9h07MKMnldRrapbnZkL2/GgMIioNq2TQ6lihVpgIGXlUA+X33445kR4r3C8/UWGxH6Suo1gp1zs3Wf23NQFgMrOT4wT/QSwe2t6LpAVMmcJk0gYDaZXEv5GddxfhYHuJcQx16IP4O+I0hgqacMMREymA0QN62Gdq4OCIB6gttK+ckdhEKKql78jgDIx2twHiNtO4fBlLzTDc28VMCaMO13SlzEAyUl2H1nSULPiGUYRtjf0J5he0iqn0tMguAz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b4c0ed-6f8c-42cd-1eb6-08db65acfa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:09:40.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vt7hJSlstgXdorWCllibyQc3a6I3UUJwzttdOmxA5tlrTNd5qC+91GlFywdOgdVEUy1TYwwr0gHa5r1TjVYn/oa6mUkGO/LnigIqVMHQzow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8894
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
