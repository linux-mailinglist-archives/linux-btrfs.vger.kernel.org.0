Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C056B2BCE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCIRP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCIRP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 12:15:29 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E528215
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678381985; x=1709917985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lpqxRZ2TcAVcAuTOa2QZ7AR3N8xx7OeG1j1jwJEfW0g=;
  b=m5dmjpjn79/f7IBQPURc2AUmaZvfm/b+8+Iihr4sC9VZ3qMJKIgXUMq2
   Qhym/Vmkg8NpHeM0XAVD0oXXf50ZYBdjby9DtFD0NERtvyEWC8Zypv6C5
   +YcsrcY7CEk6NU+jMhlw1FsMSrv9lA3Jm/aGCssi7bYUq0ZbwktzzPJRu
   YyRrb5lzCAPZUc9ZVxtha/sD4/fInbyyM463bDSpN2YiLLkjbw38RM9TO
   pdjME2Aqbl7ucUywHt2hozW4dwNdrohrwypL97EK0tHjfrgFSloOYKpOk
   QDO8h16Mx2GNbMgbfiZrMX0Xx4QjH0RiE5kzoguJe4cLpsbWg9vUAxcVU
   g==;
X-IronPort-AV: E=Sophos;i="5.98,247,1673884800"; 
   d="scan'208";a="337241353"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 01:12:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T91+PudwvMgfsiX1g1ikApK4hJkCsmSZvEBWF0fEbLm8LLVVHtMhbZwHW9cyz+rDEvgGmdhMCpUu4bcyKxVPTEFxeKKchHNmOC2W5m4/VGMff6f1hwcqEJlhEQ9m7arfZWH9MAXB4lKgYZVrdKALIHsfyzHfvRjcqpKlSIHrxwwUosQTDvDK7Db8iJCrR0gfXg422T0ZnLmSJ1a8jKlTsgx5V2O140jVwvr14d1kjuIfob4E/go1cuV1WqrwjFp8K5SD5BDIVZqZxIqWuiLhLgdNl4jH2weljbP3wWmI2LD3/DZ/Gg6i59Oa530Ip05Un0ZN//D54YeY1cqPysPdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpqxRZ2TcAVcAuTOa2QZ7AR3N8xx7OeG1j1jwJEfW0g=;
 b=aWP9bTatm6smPn70bR/Yz1DGgJfY9+zc6IlDwLy+9DTyxQ7ii4fSJLjM6g5QaLOltz9pJCE7ckLYN72dN2fIICn0eq6hSG5uwO34IH+BvQJkWamWcwqGfLq5V+WyfMCDm15dDP6dmVBY9CaSEgeg0GdIoARhPlk+1bkmth301cZuDRLSM5pJ1nl1b0cvOw/ZtKoyf6+cwaaubwNQgWWoSTIS66mq0e9Cc+eeXZoYa9cUVUE1im/z4ATair2/FJGc5ua4z8d2zI1pwxMhu2MvDsbt5SfhJSdt8bswjiwsIc1F004W+60lMs4kvzkQ7bJ1PEjA1lpDGHxZpV0v3ZDO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpqxRZ2TcAVcAuTOa2QZ7AR3N8xx7OeG1j1jwJEfW0g=;
 b=VEeNTmRkQIhni3iXh7KTRc2ROrmNltdFAdlu8VusjH9Hr3O8G+zI00MwxrfQFru8BdWJEEfuUBoMHr8aVLo8dx5ExNVBmkVbyvKud3wl2pyhUe34C7gBdOg3rTIG7QcPHH4OILE3AWon7pFu50PFEly39C8pJS6pf41Papi6ZOg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7683.namprd04.prod.outlook.com (2603:10b6:303:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 17:12:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 17:12:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 19/20] btrfs: use per-buffer locking for extent_buffer
 reading
Thread-Topic: [PATCH 19/20] btrfs: use per-buffer locking for extent_buffer
 reading
Thread-Index: AQHZUmbD7K2U8pQcGEG/uhYI70yzeq7yr/aA
Date:   Thu, 9 Mar 2023 17:12:54 +0000
Message-ID: <d7d2d4ef-6f5c-961e-4dcd-2758d7b8a7a0@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-20-hch@lst.de>
In-Reply-To: <20230309090526.332550-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: b2e7273f-362d-4b77-3768-08db20c18594
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/YlwNhnwgt+E6PdK+qKnNpAFwWoiS7p5LjO8W5hvsr7VFrzHcU0GT3dcPPSxrRMEckssxol3ksn/dVmKER50FjXMXUp+MvbBGpXfzyF3OnfIxVBQMveRhz0TvMBfrxpFlE+r8y+KydQTSzdLR1pe5MzZYeE6S1EhnfwCufruL9hJQt26dqOpB2syDWrwNu8s+Jah/fExna2b00Xuw8ievBv76M7hxDpVKY1jbODGCGJol31tqGjemrCPqsv/pseduXd5ZrLvw8UuHKXAsNxMh/s5xQna9gSUUs7HAZYI/poURgLvJwI6I13zaAheSfBMUF7GHdlHWrFjL2QfQAFk25i/5n8b2DGxb+HIfZlcxh4kqncUrszsbnK/OjM5xvYW+r1B1xw540KYIDDaV877UWYPQ40Kz+NoCN64TW4zPR+YapRQz6fOSJ+cYuQCNWSLfSuc20cA7IXqlgCagqQIDnA1bMwxONmqN4J1qbsAG063GQ2/f+ymqvU2WP4FYdom1jlX8FsrI4rW8B617yOrECxaYicT239nXycg9zQXp0mxVVI+ZrBzt3oR32AVzwvCCXsWujPBQ2GhAIMxRDjUfwNYvYau2o/NyNCJoWg37RG1L7ZXnooz0kJRRLMoZRS/Z13e8aoBMmuYlM2J6dHktjauI/cZ7vXIfYj7r6DWA0XtEoV9v657UtF2oWaALuF51j9ymN3yDEXr7t03E5b/MYgdW5S9lvXg3YijlA1UNfTIZSXdELYZc/7gbc9VtiEA36R9Wh0vlK+/62b4GVWaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(31686004)(110136005)(36756003)(38100700002)(86362001)(186003)(31696002)(38070700005)(122000001)(82960400001)(6506007)(26005)(53546011)(83380400001)(6512007)(2616005)(5660300002)(71200400001)(316002)(478600001)(6486002)(41300700001)(4326008)(4744005)(2906002)(8936002)(76116006)(66556008)(64756008)(66476007)(66446008)(8676002)(66946007)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1MdE1hUFExUnJPcnB4TmtOakMzZUdyK1JBRFU1dE9TMVNQR2FnZVVDdmZt?=
 =?utf-8?B?V2duRlRhc1BObnNEWStIYldDdkxDbFQ1Zk9FV0tSdzA2aXdwR1JZUXNhdTJF?=
 =?utf-8?B?OGJscTlSVHdoQ3ZaZExZNGljbkJxMTIrYTRGb1NzSjEwNklSQUVrVytsT3lY?=
 =?utf-8?B?MkxpejZMRHVvSitwQnV2b2xxRlN1bk1rY2xHK3dFTXFnRlBQMTdtSkJ0L3U3?=
 =?utf-8?B?V0JwK0VsKzgrUHh2TWxLWGQvY0RqNWxIY0xuQVpYWUoxZU1CNHQ4MU1nMTUx?=
 =?utf-8?B?dEEzOXB2dWNrUExndTllMFlPL0kyVEQvVS9kN2VKVHFER2V1dVVud1c1TnRD?=
 =?utf-8?B?WUoyaGJsckpTck1UVTg2UktRa0Q1YkVqY0lGZWhlZW0xWk1nVWNzbTNZNUJ0?=
 =?utf-8?B?SjBrWitsRm9RNFBaT2hmNENCbXFqbSt2SXpuQnVDbDVITEdRczU4LzhkZzNU?=
 =?utf-8?B?d2s0QnU3UGVmeldoMFRjenVQeFpWRUZvSmVjalZ4dVhVV3l5ZFdFN0ViT2Rm?=
 =?utf-8?B?bnhZell1aDdQdXU1TWI0eXFLMDVlczUzUXhvd3JFOWVDN1YvMjZaRldnb085?=
 =?utf-8?B?Z3pvOXJGaXhlY25aVGxSd1VIL1k5NGZUOXFWSWNHWk52b0d0cGljQ01MSlZm?=
 =?utf-8?B?VVBjaUdsYThqU3NYMzdZYTFHQ0R5bmdvY3BUZ2o2WDlIODA1bEFwNlpMWVVB?=
 =?utf-8?B?K2d3Tk9ZdkRPREVvS0tYSENMcnRFcjIwbnduV1I0eGh1OHd0R3Q0UHZLSnVW?=
 =?utf-8?B?QW5KU290OEhBdXZBaTlOTTdmSTBoNk1BOTZuYkFhVnRqdU9DUmtGQkNKdzkr?=
 =?utf-8?B?NVJQRlVSOU5KbFd6ajFaZnhCQXJabFlTSGdtdHE1dkFhMElCYXQ5T2h3bTdK?=
 =?utf-8?B?bUNIbkVMdytuVlMvRWNUUk94MTNVbGRuVnlIL01XK1RrNjl5dWNwTUJrbDI1?=
 =?utf-8?B?SWUwV0hXanFzbnpjNXBuMXU0aElZbFV1LzFERHFVaEc5N3E2cjNFbjMyWVAy?=
 =?utf-8?B?RG05NGhpV282MnBodXRmbUxYU1MyQnFmSVgrNTYyNzJ1ZktLcVNlWGhQNjY2?=
 =?utf-8?B?a2tCaXFpUmd0aG9hcStrN0ZyYUxGdGxYQWpWUGxSalBLYjJ6b0loWXhuUG1G?=
 =?utf-8?B?T28rajVPcFM2ZGpWRTJ2eS9aOVZPZ2crUkdnL3NoOElUU0VYQTdLMXVFR1VW?=
 =?utf-8?B?V2hsRklhQjhIS2ZtTWxab2NXR1JOSXQ2bmF2OEx3K2Q1Vk5GZFhYTmhCL0Mx?=
 =?utf-8?B?ZXpmWWI1K2s4VUV1bnZUV2pEcVBhVERIVFYzTVdJRmNGZ09JWkZ0OTMrSmM4?=
 =?utf-8?B?cEwyMk45eEJaVncraTQ2OThIUS9yRytNS1hrUzBsUW8yZnpFbTBFVC85dnpG?=
 =?utf-8?B?MTNSbFIwMUcwTWFCUElzbzA3THhYQktSOFlZSFVTSmw4M0FwZS9LTTcxay9J?=
 =?utf-8?B?NGxpMlJNVTlpSFpaRlRwVURJUHdJME44c0RSMXYwdDJ0RTlERFZ2Vm5uNTlO?=
 =?utf-8?B?cEI3eVlhQWtjZ1VVNWxmWDd3cHRpOEx2eGhrVitua010WGxGN0dMODJCYUtR?=
 =?utf-8?B?MzNrbVgrRE5GQjE0SjFJTXNPU01XMGJmTHAvc3pWTVRGWk85STdlRmVhcTVX?=
 =?utf-8?B?azY3U2YxOEd4K1Fsek9hL1JyU1hlb3dzVEI1Q2o1eGpvaGJCbUl5eS95eUMw?=
 =?utf-8?B?RjU4YkN4aDR5eGZYRytmRXJHTnkxMjAzbjZQenl3TXpab0pjRllrZUMrZk5m?=
 =?utf-8?B?NThxdG9ZOUhPSzg5WUJsZUdicTByTXB2VHBhODdPMFRFUjJxeFFpSzluaUl1?=
 =?utf-8?B?d28rd1dqaHRQUzJ6Y0lxL2hsSGZnaS9NRmRRbXY1aS9xU2J3aDdUT1VKdGVx?=
 =?utf-8?B?SUNJNzk4Und4ZmRaRWVQYVRnSjlNRmV1Y3RsejMzQ3lSaW5MQnFwZTdlNHN4?=
 =?utf-8?B?allRVVNxQm5LeEt5czdaUmdIQ3VQYk94L1orR2FSOGl1TFFTam9DeTluUTFi?=
 =?utf-8?B?akx2c25SbjZQc0Fzazd0OStRMmoyM1VvbGdkRkJTRjk1emN1bitPTHVHVUJ3?=
 =?utf-8?B?M1hkMi8vVlBpQTlsYVJCWHVpMGl5VU1VbVJhdStCSFZSWFRyYUJPRWgyL3Np?=
 =?utf-8?B?RVgydWJDMXV1TG9BN0FsV2JTLytYaXFON3d1dFYxQWZUd1g1NS9KQzA4anRk?=
 =?utf-8?Q?WjiqtWFJwaG3SVSu/7+5Ppo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <121420ADF3B074499D913CA017F45A4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tDP7iw4yaojFJDhCcU1VyooHXHH/19U+bHpYjq/aArYxSyOhbqkFY66j215iZLF4QHVIbG/rYmO5GdlJiW71J/WhLZW2464i3u3pFqqOA2S1Ipru+TLpD6+5TL1jldkCFv1SsmtSfi/7KlrsyLdxrKO3W0hGZYpL75YmpGCoaw1//c9NHXzFiPilPKIfqsBG6AK+3RJKfCP6kaG8Q5VN7iCqIaRb8xcILufrInvStKqEUrlxi398blC0yV24lZYCKemx4n2C3tnAG4rBUG6wvZEQiUgEdt+oy3DjDdJWkS8sj/MwcX7LDWlAoGice1pr7f/T8pnSj5BgLSK2f9doLuKFkjhBuCL05XYmhCQeNw/+K0UfL0cfqOTxwJOmjOCi6Tbz/gVijrI+kCQ+++41L41dqO/og0FrmJQC/1qI8gAKsXDxSJ2YnJkamgEz+doTTsKtFcJoMXioPrRt5zGxWyElDBRlY4k6bdgw+qPi941QnuoZtqVIx/gCJDPUdqCIum1ftukDnBtpwR3wRPLJWuDU2sBlRek7KFeAapVYrrPk4yLted8YOJJX5svA1zvFlBZaLP1nBrd7prhrfWFNxzC3XxQ8KXyh2bOu67fUtsg3kWCVd5KcvcyNQ2kdVfRCz2HcfZLyW9eDfAAnocXz8t4whRhYmcAyt7ifcG1R0ZmoJHC+VoVYJWhallkIO82SuSZHTB5vhI/MjsuOkDj+wXLDzb+yp7Q8L7X0mTfZXIu9eLkYw1KWcik39AccpcmUle7q1J8L5KDC19+ueuXHR0YVHQ86hjGgYWFsOZgmrPety3LcLrP6hNimTfPjI+rK4rYR8NJ8tyggepUIN1Koxv/hrFPTwx8fDDXd01Kt4viFsMzs8MsWmoTs5/yRD2kr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e7273f-362d-4b77-3768-08db20c18594
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 17:12:54.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGozqEHsduvUd7hH0QkXsQwR15qgh12DxsE5frqun7GQcMO+wzfwuUQHsvRHRlRWMXK7Y12TPe3GUq6Zk1WT7xOgTpDovyrn+bthgdtELNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7683
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBJbnN0ZWFkIG9m
IGxvY2tpbmcgYW5kIHVubG9ja2luZyBldmVyeSBwYWdlIG9yIHRoZSBleHRlbnQsIGp1c3QgYWRk
IGENCj4gbmV3IEVYVEVOVF9CVUZGRVJfUkVBRElORyBiaXQgdGhhdCBtaXJyb3JzIEVYVEVOVF9C
VUZGRVJfV1JJVEVCQUNLDQo+IGZvciBzeW5jaHJvbml6aW5nIHRocmVhZHMgdHJ5aW5nIHRvIHJl
YWQgYW4gZXh0ZW50X2J1ZmZlciBhbmQgdG8gd2FpdA0KPiBmb3IgSS9PIGNvbXBsZXRpb24uDQo+
IA0KDQpXaGlsZSBJIGxpa2UgaG93IHRoZSByZXN1bHRpbmcgY29kZSBsb29rcywgSSBkZWZlcnJl
IHJldmlld2luZyBpdCB0bw0Kc29tZW9uZSB3aG8ncyBtb3JlIGluIGRlcHRoIHdpdGggdGhlIGxv
Y2tpbmcgb2YgZWIgcGFnZXMuIA0KDQo=
