Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD15FA727
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJJVzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJJVzR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 17:55:17 -0400
Received: from spamschutz.webhoster.de (spamschutz.webhoster.de [212.172.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55D33437
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 14:55:14 -0700 (PDT)
Received: from mail.psa14.webhoster.ag ([195.63.61.219] helo=admiralbulli.de)
        by spamschutz.webhoster.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <admiral@admiralbulli.de>)
        id 1oi0jk-000PJr-Bo; Mon, 10 Oct 2022 23:55:04 +0200
Received: from psa14.webhoster.ag (psa14.webhoster.ag [IPv6:::1])
        (Authenticated sender: admiral@admiralbulli.de)
        by psa14.webhoster.ag (Postfix) with ESMTPSA id 4CA347020CE;
        Mon, 10 Oct 2022 23:55:06 +0200 (CEST)
Received: from ipbcc08fe0.dynamic.kabel-deutschland.de
 (ipbcc08fe0.dynamic.kabel-deutschland.de [188.192.143.224]) by
 webmail.admiralbulli.de (Horde Framework) with HTTP; Mon, 10 Oct 2022
 21:55:05 +0000
Date:   Mon, 10 Oct 2022 21:55:05 +0000
Message-ID: <20221010215505.Horde.RZkIzcYk-4PFibw1N4xzHqt@webmail.admiralbulli.de>
From:   admiral@admiralbulli.de
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available
 RAM - rev2
References: <133101d8dbce$c666a030$5333e090$@admiralbulli.de>
 <9167e4a5-252c-0192-6814-da91e3692b88@gmx.com>
 <c57e3674-255d-ab3c-a386-479b84c19eee@gmx.com>
In-Reply-To: <c57e3674-255d-ab3c-a386-479b84c19eee@gmx.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-PPP-Message-ID: <166543890684.749238.5721446470576252178@psa14.webhoster.ag>
X-PPP-Vhost: admiralbulli.de
X-Originating-IP: 195.63.61.219
X-iStore-Domain: admiralbulli.de
X-iStore-Username: 
Authentication-Results: webhoster.de; auth=pass (plain) smtp.auth=@admiralbulli.de
X-iStore-Outgoing-Class: ham
X-iStore-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+/AseVP+wIRI0RRIxu5Ms+PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zZqREl0R85+rGYi6DSby0R5mMdBd5jwLAmlEhPONBBSOoB
 TcI6wNOKq/VipP56WpUPmOPCcmrlxrVn4hBIRExVAXDkcXwqI3EzqRI7b1h6dsFEkT3rajKVwq+u
 Wp7fr2I4PWJM2zMugzmIRtzFHL4aEcvkXRZGBwNJkmmwWhkNpadBHcSOUYQH8hrKwbRu5U4e7VM2
 alTUNsoANW4ONNcxzFnVeeHz+MrXcGtqhB1bW9blgCJ3mX3WksJLEYYwhcM0pUaEGovDWIr6wzKm
 7U5w+g3Zi4XyO7xiooIY8oApwPZsEhnzWgZmn4n0yUjDMDiKwjRI55s4yThxC7fDUF/RKWA/Z0hB
 oECwUV7RHo4b88hDqF0K58xL38EJqny9AYf6dVXPU1ZVV1D/5DkRwOPLi2+ZrpvcQF0mktyij7U2
 V1mYqffhoXnZj6JC/A974b1RNsZiKnQLqUyI6hW5+I7Cls2BUBoMzqGyQdYmDrI+sHnWbzQvBXuX
 n6n3jQ1TJMLDx9dgYfO2muGH2bNdOKfOzon1aL1KuwjoHteKIt8tLa0jiD6XqsJZtjQxlyCdsex6
 Qx+tcm8Tg4DIAqFbXzDYyf73B+f05JKKIC2LE+nDZly34B25702/TpvEfLHLL8oVU0yVdaPrEJ98
 clUaxFq61zmVHmTyQ7MVValWHnLHXBEVniihuDwEGDcmr6e3OPQqMrfeXUr5nN6bzXP1KYdKClRJ
 1RiGtaChbAgJHb4fLEKEyPYHmQWKISclMej0r1GP4OjaT7iF/DA036EFxGo2ZuM7jUXIESohoO51
 xWmU8YTTKQ4CnjarNh6FVn5HN7gpX5T81Xftpdt9Y5g7pAWHKMJSNuQddpTqHo9TGN7JvIW68pc7
 2DW2JzSJc7wCkr4kZAlCUhfn9Dl8Ig6ZDL1pNKVGhBqLw1iK+sMypu1OcKFPCCifbr4YUU4qurgv
 MWX6cP7qTZmrAoJkb1Awzvwt0LRMfD3Nycs7jZ0nH6Yd6A==
X-Report-Abuse-To: spam@spamschutz.webhoster.de
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RGVhciBRdSwNCnRoYW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIHF1aWNrIGFuZCB3ZWxsIGRpcmVj
dGVkIGZlZWRiYWNrLg0KSSByZWFsbHkgYXBwcmVjaWF0ZSB0aGlzIQ0KVGhhbmtzLA0KYWRtaXJh
bGJ1bGxpDQoNClAuUy46DQpGb3IgdGhlIHNha2Ugb2Ygc2ltcGxpY2l0eSwgSSBib290ZWQgaW50
byBhbiBVYnVudHUgMjIuMDQgKGtlcm5lbCAgDQo1LjE1KSBsaXZlIHN5c3RlbS4NCk1vdW50aW5n
IHRoZSBidHJmcyBydyB3b3JrZWQgbGlrZSBhIGNoYXJtLg0KDQpkaXNhYmxlZCBxdW90YToNCiAg
YnRyZnMgcXVvdGEgZGlzYWJsZSAvbXltb3VudA0KDQpkaWQgc29tZSBjbGVhbnVwOg0KICBidHJm
cyBiYWxhbmNlIHN0YXJ0IC1kdXNhZ2U9NSAvbXltb3VudA0KICBidHJmcyBiYWxhbmNlIHN0YXJ0
IC1tdXNhZ2U9MjAgL215bW91bnQNCiAgYnRyZnMgc2NydWIgc3RhcnQgLUJkUiAvbXltb3VudA0K
DQpSZWJvb3RlZCBpbnRvIHRoZSBvbGQgZGViaWFuIHN5c3RlbS4NCkFibGUgdG8gbW91bnQgZXZl
eXRoaW5nIGFnYWluIHJ3Lg0KDQpUSEFOS1MgQUdBSU4hDQoNCk9uIDIwMjIvMTAvOSAxOTozNywg
UXUgV2VucnVvIHdyb3RlOg0KDQo+IE9uIDIwMjIvMTAvOSAxOToxMywgUXUgV2VucnVvIHdyb3Rl
Og0KPj4NCj4+DQo+PiBPbiAyMDIyLzEwLzkgMTk6MDMsIGFkbWlyYWxAYWRtaXJhbGJ1bGxpLmRl
IHdyb3RlOg0KPj4+IERlYXIgYnRyZnMgdGVhbSwNCj4+PiB0aGFua3MgZm9yIGFsbCB5b3VyIGdy
ZWF0IHdvcmshDQo+Pj4gSSBoYXZlIGJlZW4gcnVubmluZyBidHJmcyBub3cgZm9yIHNldmVyYWwg
eWVhcnMgYW5kIHJlYWxseSBsaWtlIHRoZQ0KPj4+IHJvYnVzdG5lc3MgYW5kIGVhc2Ugb2YgdXNl
IQ0KPj4+DQo+Pj4gTGFzdCB3ZWVrIEkgZXhwZXJpZW5jZWQgOTklIHRoZSBzYW1lIHRoaW5nIGFz
IGRlc2NyaWJlZCBoZXJlIGJ5IExvcmVuIE0uDQo+Pj4gTGFuZzoNCj4+PiBodHRwczovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9saW51eC1idHJmcy9tc2c4MTE3My5odG1sDQo+Pj4gb25seSBkaWZm
ZXJlbmNlOiBUaGlzIGlzIG5vdCBteSAvIGJ1dCBhIDQwVEIgc3RvcmFnZSBtb3VudGVkIHRvDQo+
Pj4gL21lZGlhL2J0cmZzMS8NCj4+Pg0KPj4+IHF1aWNrIHN1bW1hcnkgd2hhdCBoYXBwZW5kOg0K
Pj4+IC0gZW5hYmxlZCBxdW90YXMgdG8gYmV0dGVyIHVuZGVyc3RhbmQgd2hlcmUgYWxsIG15IHNw
YWNlIGhhcyBnb25lDQo+Pj4gLSBzdGFydGVkIGJhbGFuY2luZw0KPj4+IC0gc3lzdGVtIGdvdCBj
b21wbGV0ZWx5IHN0dWNrIGR1ZSB0byB0aGUgbWVhbndoaWxlIHdlbGwgdW5kZXJzdG9vZA0KPj4+
IHJlYXNvbnMNCj4+PiAtIHB1c2hlZCByZXNldCBidXR0b24NCj4+Pg0KPj4+IEkgY2FuIG1vdW50
IG15IGJ0cmZzIHN5c3RlbSBwZXJmZWN0bHkgcmVhZC1vbmx5IGFuZCBhY2Nlc3MgdGhlIGRhdGEu
DQo+Pj4gQXMgc29vbg0KPj4+IGFzIEkgdHJ5IHRvIG1vdW50IHJ3LCBteSBzeXN0ZW0gd2lsbCBl
eHJlbWVseSBzbG93IGRvd24sIG1lbW9yeSB3aWxsDQo+Pj4gZmlsbCB1cA0KPj4+IHVudGlsIEkg
d2lsbCBmaW5hbGx5IGVuZCB1cCB3aXRoIGEgcGFuaWNraW5nIGtlcm5lbC4NCj4+Pg0KPj4+IFNv
LCBubyBwcm9ibGVtIHRvIHN1Y2Nlc3NmdWxseSBib290IHdpdGggdGhlIGZzdGFiIGVudHJpZXMg
b24gcm8gb3INCj4+PiBjb21tZW50ZWQgb3V0Lg0KPj4+DQo+Pj4gwqDCoMKgIGFkbWlyYWxAc2Vy
dmVyOi8kIHVuYW1lIC1hDQo+Pj4gwqDCoMKgIExpbnV4IHNlcnZlci5kb21haW4ubG9jIDQuMTku
MC0yMS1hbWQ2NCAjMSBTTVAgRGViaWFuIDQuMTkuMjQ5LTINCj4+PiAoMjAyMi0wNi0zMCkgeDg2
XzY0IEdOVS9MaW51eA0KPj4NCj4+IFlvdXIga2VybmVsIGlzIGp1c3Qgb25lIHZlcnNpb24gdG9v
IG9sZC4uLg0KPg0KPiBNeSBiYWQsIHR3byB2ZXJzaW9ucyB0b28gb2xkLg0KPg0KPj4NCj4+IElu
IGZhY3QsIHY1LjAga2VybmVsIHdlIGhhdmUgaW50cm9kdWNlZCBhIGxvdCBvZiBxZ3JvdXAgb3B0
aW1pemF0aW9uIHRvDQo+DQo+IEdpdCBkZXNjcmliZXMgLS1jb250YWlucyBzaG93cyBpdCdzIHY1
LjEgZm9yIHRoZSBvcHRpbWl6YXRpb24uDQo+DQo+PiBhZGRyZXNzIHRoZSBzbG93IHBlcmZvcm1h
bmNlIChpbmNsdWRpbmcgaGFuZywgaHVnZSBtZW1vcnkgdXNhZ2UpIG9mDQo+PiBiYWxhbmNlIHdp
dGggcWdyb3VwIGVuYWJsZWQuDQo+Pg0KPj4gQWx0aG91Z2ggdGhhdCBvcHRpbWl6YXRpb24gYWxz
byBpbnRyb2R1Y2VkIHNvbWUgcmVncmVzc2lvbiwgYWxsIHRoZQ0KPj4ga25vd24gcmVncmVzc2lv
biBzaG91bGQgaGF2ZSBiZWVuIGZpeGVkIGFuZCBiYWNrcG9ydGVkLg0KPj4NCj4+IEJ1dCBmb3Ig
b2xkZXIga2VybmVscywgbGlrZSB5b3VyIDQueCBrZXJuZWxzLCB3ZSBkb24ndCBoYXZlIHRoZQ0K
Pj4gb3B0aW1pemF0aW9uIGF0IGFsbC4NCj4+DQo+PiBUaHVzIGluIHlvdXIgY2FzZSwgeW91IG1h
eSB3YW50IHRvIHVzZSB0aGUgbGF0ZXN0IExUUyBrZXJuZWwgYXQgbGVhc3QNCj4+ICh2NS4xNS54
KS4NCj4+DQo+PiBUaGFua3MsDQo+PiBRdQ0KPj4NCj4+Pg0KPj4+IMKgwqDCoCBhZG1pcmFsQHNl
cnZlcjovJCBidHJmcyAtLXZlcnNpb24NCj4+PiDCoMKgwqAgYnRyZnMtcHJvZ3MgdjUuMTAuMQ0K
Pj4+DQo+Pj4gSGVyZSB0aGUgcXVlc3Rpb246DQo+Pj4gSSBhbSBsb29raW5nIGZvciB0aGUgb3B0
aW9uIHRvIGRpc2FibGUgcXVvdGEgb24gYW4gdW5tb3VudGVkIGJ0cmZzIGxpa2UNCj4+PiBkZXNj
cmliZWQgaGVyZToNCj4+PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtYnRyZnMvcGF0Y2gvMjAxODA4MTIwMTMzNTguMTY0MzEtDQo+Pj4gMS13cXVAc3VzZS5jb20v
DQo+Pj4NCj4+PiBBbGwgbXkgdHJpYWxzIGFuZCBjaGVja3MgZXQgY2V0ZXJhIHdlcmUgcGVyZm9y
bWVkIHdpdGggYnRyZnMtcHJvZ3MNCj4+PiB2NC4yMC4xLTINCj4+PiBhcyBkZWJpYW4gYnVzdGVy
J3MgbGF0ZXN0IHN0YXRlOg0KPj4+IGh0dHBzOi8vcGFja2FnZXMuZGViaWFuLm9yZy9kZS9idXN0
ZXIvYnRyZnMtcHJvZ3MNCj4+Pg0KPj4+IEkgYWxyZWFkeSB1cGdyYWRlZCB0aGUgYnRyZnMtcHJv
Z3MgdG8gZGViaWFuIGJhY2twb3J0IHY1LjEwLjEgYnV0IGRvIG5vdA0KPj4+IGZpbmQgYW55IG9w
dGlvbiB0byBvZmZsaW5lIGRpc2FibGUgcXVvdGEsIHlldDoNCj4+PiBodHRwczovL3BhY2thZ2Vz
LmRlYmlhbi5vcmcvYnVzdGVyLWJhY2twb3J0cy9idHJmcy1wcm9ncw0KPj4+DQo+Pj4gQ2FuIHlv
dSBwb2ludCBtZSBzb21lIGRpcmVjdGlvbiBob3cgdG8gbW92ZSBmb3J3YXJkIHRvIHJlY292ZXIg
dGhlIGJ0cmZzPw0KPj4+DQo+Pj4gVGhhbmtzIGEgbG90LA0KPj4+DQo+Pj4gYWRtaXJhbGJ1bGxp
DQo+Pj4NCg0KDQoNCg==
