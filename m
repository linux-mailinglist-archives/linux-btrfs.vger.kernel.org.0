Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5646B22AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCILWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 06:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCILVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 06:21:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025C270D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678360676; x=1709896676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O8djlEL57pBmqbsu3efxMH17G6p2YKYeFBny0Rnwxwk=;
  b=IPMJffa0ifn0TX3yoAKAQ4Z28ZGDDGGFJd7wzXMULhaXpB6XID/aERnP
   VdU5pmiOwOeUG0DWHKS1gR59TaLhq8duJr3JSPdAJIPVehUi87GHgYlqV
   J86xwuwCR7tDWWKkTGMk6Rjdk32L62L5mRBb+kJebv5c9G9euIa77JZBi
   pOxJGFUAj4aGJZbxDxqKcPGJgue074q/AyjeB5sieH52doStcxfAtp+MJ
   2hG/edIfPeFxC/ZXwR4UCzhPaphq7+nAuP8nbVPT+TC45p4fTwzZzVryt
   e/kN08Cby7K4LzdOK6uZauPRcD/XRHTAGHNwfy1TGs6iCUSko4xynYMVp
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="337210638"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 19:17:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkP8GzETE2tSAfsKYyAL4fDwi3eQsiFLNbgXToiWEhG8UcPr9yM/Vq9D75nTsN3b6M453RErEPJPiddlCBsDEErIRRPLSoRxWR/7rSC8z2MNBE0pvAP0Rd9auN4Vrh3VMOvXBZypaUH7gQabHvqPHH4nUn24v+mJ0slxpD+uDUjtu+7ir77VMInU1Gqk5jDtMTyN4wdgGi+kMLuqQ6bCagh8fESvIDUeyEvc13QKQSB7sJCX0kTySpeFxeOCuSg7Jrp4uXUdv5/bg+pIpJujZIwPsiG1+BEJi92oCEgLoAMFHIp+R322o7qmoh/SBhUl4zDhg9B+AjMeFueaMavGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8djlEL57pBmqbsu3efxMH17G6p2YKYeFBny0Rnwxwk=;
 b=lyRgUNVotZg4rveyuqkIdv/fAPfCzAe9EZ15M+8zW9ddWjx+shzeQvA56z2xfwZvBckqfmPEKQkBQNr8Kv8TIZv3Yh1kiOrbF8ZRbeaZLy2yinAMYHL8hogQEFGJNGuvsmJmbq9O172iBHbnCTNQzQfEOFCDY3/4TmBkpc/MlFjDR7lWpSBmXBO22i42spydkQ+43OSyozuCCLPVD0ong1psRU5IzaPiYDFn4t2LhiQhVHW2oXzGJzNF6pi2Zo9LoCKDyNnfBNKiAafFXZlV0xf3bhT9TxIP0wy/vy1+qZt05A/ehPqBqb+GHVHbXTpu+ogvSRLVNHZWr/FSRxlMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8djlEL57pBmqbsu3efxMH17G6p2YKYeFBny0Rnwxwk=;
 b=MuHDOjHArmHRfotMcZ6I2eueC9G2+AHTY78C6GhaLL7qUH1v+laxRCxzxVjujXLQMl62ycUPeKKNkSwmeg0PT7oBRTeuVYPd+VC5d7L6wwKMmbM4thy0x7h/SDFtj+LMs4CIQ5jbAXKbDaRY4yt9tYUogLh9IDK+r2AsrpNKrYs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0288.namprd04.prod.outlook.com (2603:10b6:300:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 11:17:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:17:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/20] btrfs: merge verify_parent_transid and
 btrfs_buffer_uptodate
Thread-Topic: [PATCH 03/20] btrfs: merge verify_parent_transid and
 btrfs_buffer_uptodate
Thread-Index: AQHZUmaGp9u7jVjbe0S+Qa7jc9iKJK7yTMCA
Date:   Thu, 9 Mar 2023 11:17:47 +0000
Message-ID: <cbeb9ad7-ae37-4bbf-8955-b8134197171a@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-4-hch@lst.de>
In-Reply-To: <20230309090526.332550-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0288:EE_
x-ms-office365-filtering-correlation-id: e01501d2-73c0-4360-720e-08db208fe9d5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZKI0zS8oibhB3LSBK9UBudAhYnM8Q8l5f1X8obbVfhf0HaORXuoiV3NqY8V+pqMWZUopyiGh0klZZi9JzKAqeqNaSVEZ5T3+kMINxFXyaptBf47TKjBWSZNtEXWYYCLXo1l60nVPmNvDXF/0hEIc2DHvquGeU3GGoanTHhveC78bDoD41KnwSkVL1Hq3CxiLFzzdstKORZVFfASIFSbLG174+36Az0Qa4upTDXd7/MroC/hFpPwgno8XP0KbGVGF1Zw7i0mMgBkvbwky025D2PGK/gyHSVHFsNo5b5vVu7/sPWnUrC1DxqaJb6ZODDR++oVs2J4s3b4NbtyqUp6ORArv2KCS7o0J7rop31jxQKiBzYwcV/NQmekfJLN35PcDGz/fk3JJUEsBC7J9dRX536PMxA6OBLm7qdo2YXfJ9I8O6E6jvJ9U8VmzhwTesOSzvwQHash7Qfh+FezeYgGEBlPFWCKNuYqJA0FgXblDitGj4/pB4pj0Al/6oaViApzkDog2lAIytFiqOl0Jf4Ira8wLjWFl2GIBSvZSxwxTEcQEhMk0ge0a3wABzVEIzJ6o4fLV2pIFfbbYF6m6L6hyrspFhLLoHcDb2wGNhZJx3StE/bBD8yt9fK2FLp66VN+EHyS8dISEJZ9oQd5U4gewfVLfFzDomQeam9t2wrsW1OV3yNrrD77Qm3CBcKYfzXhBm/uASN0SA3QsmbXBxNT+TKaucet9ahmQQOI/5WRk3ndfQhsdWhqfMRC2p2ZPgXPnnETTacXuNdwEMCcBXMFJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(82960400001)(6486002)(71200400001)(186003)(36756003)(478600001)(31696002)(38070700005)(122000001)(86362001)(316002)(38100700002)(110136005)(31686004)(6506007)(6512007)(83380400001)(41300700001)(2616005)(53546011)(26005)(5660300002)(4744005)(8936002)(66556008)(91956017)(66946007)(76116006)(15650500001)(2906002)(66476007)(66446008)(4326008)(8676002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3c1cGliSDFybml4Y09FTGc0RFhFSnkwdS9lK2lKZGRjWk1LOGZmcDgxbkdl?=
 =?utf-8?B?ZzdjbldzZHcxUy9VbDhoYzVSdDZycVpIeVRaeWNBS01LSzQrRTI1YXROaFVj?=
 =?utf-8?B?dDFKbE5Va0V2OERZK00vanllbmU1d1BFQ21XdXB5a3VHdEduY0t1V1VlQy9H?=
 =?utf-8?B?V1Znd3ZmZURKdm1XWVZ2KzdPOGM0bktUeHBtR01SSFFFZVQwUi9sbzFhOXlj?=
 =?utf-8?B?ODVGYVc5ZTJoWGl5WDBMTTYvZUZLakRXNjFJUGttaVd4NFZCSVVYcHdPa2hV?=
 =?utf-8?B?eW11eDFoblRJbW5DMFk1eVMvUW1XWi84TGZQa2RsOXdYelBlc2VOVGhGNll3?=
 =?utf-8?B?YlAxNFl1MUFiQWZUd1pnZTZ3VCtqMFZFMXpqclIrQk1YenFIOUJlWGlmWFJa?=
 =?utf-8?B?WTZnUGs4MWdaQjhhZDF6dm1YNE1jbkVsTTJVdG1VdEFpTkdhNWRtY0lSR1dw?=
 =?utf-8?B?Z3BSMkZ5dDVETWNKdVVxbnhLUGk0SEZzY294Q0E3a2xRdGkzckQ2dm1OKzVs?=
 =?utf-8?B?QzJ2UHBzYTZFeFNHemprZ2JOcjdSaW1FQUU4cUxiU1FZUWJpaFZ2U3NNQlp1?=
 =?utf-8?B?bWFSbU1MbGRhVC9VS0xrWTFlSFQ1MHNaRDJTN3FsMndScUNPczExeTJ1QUhK?=
 =?utf-8?B?bmYxR3V5M1hEMER1MFNRWjVlSmhBTWpQMk8yZ1d2OW16LzBSeFhsRG1uNUd6?=
 =?utf-8?B?OUd2MHJ2L3FTbFN6ZkFETzZrWEtKbE5RRXErU3ZCSkZvdWRFMjBsME9DcE5Q?=
 =?utf-8?B?dmhqcEQyb29pc3RXRmVtdFR4eU5IYTcxQVIveExQRDNIZTZIYWVoc3QxZ08v?=
 =?utf-8?B?Y0VvMnNDOVRXVnRrT25TMHhENm84SlRpSkR3YTZrUThYV0J6NEwrYVNQcEdm?=
 =?utf-8?B?VU9zeEU3b0kzT0ZhQmxRY3J3TUxWLzIrVmhBemZGWTBkODNhaWI1dlF3aDBo?=
 =?utf-8?B?dVhEQ2ViK1AwNTFyeC85UGtndFRIYVk2d3p5UFpBR0c5RjZ2dEZuRG1IM1NF?=
 =?utf-8?B?VG5LKzQvZDZlbVlOcG9wQzR3cUZyY0t1S3ljRHgwOTY1dkVUYkgxSysxOWtn?=
 =?utf-8?B?aGJHOXZrWk9YSEl0T3FKQWxlUjlHMmtsQ09GdWtQK0x5N0p1K0cvMDRQUTdT?=
 =?utf-8?B?bUwzTG00Z1RqU3RuWkh3NTJQVXlET2JEN2E3VDhXZGM5S1kzc1JxKytyMkhR?=
 =?utf-8?B?U29qK3hzUU53ejFsckpXMUFXU1lYZTRnOXRLZUR4dGhxMXVYVGdBQXkzRko1?=
 =?utf-8?B?eU5uVlhMZnBIOUpPQndlemdYL3Y0Y1R2UUx3R01hZUM3Yk5pa0h6WW81a3Zy?=
 =?utf-8?B?cDJoM1dpamtBaUs4LzQ2VUs0aTBnci9hY29rVCtJSzNBY0VNOTRJdEV6bncw?=
 =?utf-8?B?N0h5QXJSTjU1Y3V5dno2eXNrU3MxZmpBTFl1M3lvUC91dzBhaG9LeWVqVnFR?=
 =?utf-8?B?aHRCQ0x4dVdlOHRYVnMxYmhxTC9hd3lXMFVaWERQclYyZlNJZlQzNHVDdmx6?=
 =?utf-8?B?SXNBYXNueHpvYUNocVAwbWQ5eDJFTk8zV2tNZ1hvODI1QjFRVlZrU01OdEZs?=
 =?utf-8?B?dStSQWpBZFV5Ulh0ZmN5K0V2T3A1a2R0dVo3ZjJ6aVBjeHBzbEl6VE9aRE1j?=
 =?utf-8?B?alFVRWo0MWNTVFNONFQ5dDMrSTU4UjJQUDZ2eUEzRVFMcFBkbGdyZ2M2VTdE?=
 =?utf-8?B?anBvZFR0UzRhekQ3YytFWWxLSG1HWlNLQ3RhbllmY0Iwc3dWSUIrM2lkT1VE?=
 =?utf-8?B?NHlVMWlQS1lqNGZEQzlpeU5mcHF5NW5ITUhwYVBoK3A1SFdrZUZyOEJRUGFS?=
 =?utf-8?B?NkpEajRBNWV6a0s2R1o2bGpjR295Rlo0VnhnVHZjYytYYjBvUGJNeHplcGFF?=
 =?utf-8?B?VDdZM1phdzVEWkFHU2VBNlJuYjRDUmM3VFY2ZXBTYWZnSHppcWw1RFBsRGNI?=
 =?utf-8?B?cUQ4ZW50OWhVWngxcC83VlplQnJkbmU5RnBmZDc3Q05FOXVMV0J1YithSFdP?=
 =?utf-8?B?VmZKWDNVMGRTQ0tLTXNFeXBWK0ZlSlJ0UU9KSXhLT0pkMTNaZDRTQmwyMThP?=
 =?utf-8?B?OGxWK0RyTlJUMVFuWWx0Y2lXMzNLTG5jMnpPaGVIcEd6VjVGNzEycm5oTjJ1?=
 =?utf-8?B?cmFpbEdaQmg4V1NXTkkyb3pQSWF0UzdXanBBSVpseHR6N2xiMlo4Nk1EQUdC?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A3445C5A35D04FB36201A9B1885F1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5xUMWbyN/pIpZu4XliQPVx6K8jMONxF1HNGAHOYWLJMqBe+CG7g8mlh9k16L3NXWaGaCWqjOTa6y918OkgW1KgWqM2jdasVzTtNhozbykbsBHugJd0Ln1UZENVSdvg69/5Gchim1OKTLjp7LvDb8oZjPoQNC81BtG/C2Sk0JGbVAey9WAidiEA0YE3eyoIUaYyTk2UWvUdat5wFT2dPn9GDKTLmwqUEB5dFJZ5TxZr0H/0ihHN9ND888+OmSVoRcHvFRTp7b5adQyZLSe8NpQo5yYJMPxdisT/un7utm/wLGjAnap20ni6qo1dse/y6x8A3xBj8V871Ti6IRphgfUEhndQGsAWRW3EUUqxvW67Mqnboyb1dW3YZHe2ZPUFr8p1Oc1qH5uVnwbXvfbBmTDDuafbFkUrcxRq36IDgO0X+IvP4RPRRRY9jp3LVh/4Lsf80mbGn580aIlWC0HMypLtoJuWPYhq9lv5sf9WsWTNdXgZJws5Zpy/GYXyil4AMuY2LFi8TxqOAxrSnsxtWhzaFW4lHckRYPz1BlF+ghrhE0OTAvihgQBdsaimOoZqHwZOESKsu8GXf3hHm+9JEdnnkLakOMVwzS6ZWIk4Twjl5XNFd//yz3Dd5x/0nZgxJmX3VhOhWbzLwvX/CzVSPGHWcJD0OiPYq57ObyCKBCIFyawq/X2E4ypGb2w/pWBhMe4xzn5r4LyewNMnSLIh5MEwQPMcw6Gzo3m2qBcswslHrPC0Zp2gUMDIaoO9oXyzRK5HYAUwtlGRB8+3fSqUNWzjC0hWWFFwJAr3LwT18ky2Umi9s+liBDBcHcbVm0bD2NTpwKcyxMfXGam9Z48GAppMQc+jEr73B1L/l/kehyjyGejQniOfH8hS75A7I1zAUS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01501d2-73c0-4360-720e-08db208fe9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:17:47.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxkYhMFQoFjWXDyChqV/hsvxqkV54LXFz6GPO3finiYXJqCIbOXqSBfhymnVAsef9T7MC0LiJUdonEnixOEoJvSd4IUEJJDrGp9LjddsJzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0288
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiB2ZXJpZnlfcGFy
ZW50X3RyYW5zaWQgaXMgb25seSBjYWxsZWQgYnkgYnRyZnNfYnVmZmVyX3VwdG9kYXRlLCB3aGlj
aA0KPiBjb25mdXNpbmdseSBpbnZlcnRzIHRoZSByZXR1cm4gdmFsdWUuICBNZXJnZSB0aGUgdHdv
IGZ1bmN0aW9ucyBhbmQNCj4gcmVmbG93IHRoZSBwYXJlbnRfdHJhbnNpZCBzbyB0aGF0IGVycm9y
IGhhbmRsaW5nIGlzIGluIGEgYnJhbmNoLg0KDQpUaGlzIHdvdWxkIGJlIGEgZ29vZCBjaGFuY2Ug
dG8gbWFrZSBidHJmc19idWZmZXJfdXB0b2RhdGUoKSBhIGJvb2wNCmZ1bmN0aW9uLg0KDQpPdGhl
cndpc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCg0K
